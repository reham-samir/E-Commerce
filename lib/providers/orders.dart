import 'dart:convert';

import 'package:ecommerce/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dataTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dataTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  String authToken;
  String userId;

  getData(String authToken, String uId, List<OrderItem> orders) {
    authToken = authToken;
    userId = uId;
    _orders = orders;
    notifyListeners();
  }

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    // url to get my orders.
    var url =
        'https://e-commerce-e14cd-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken';

    try {
      final res = await http.get(url);

      // to get data.
      final extractedData = json.decode(res.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return; // stop fuction and don't make anything.
      }

      // get data from extractedData.
      final List<OrderItem> loadedOrders = [];
      extractedData.forEach((orderId, orderData) {
        loadedOrders.add(
          OrderItem(
            id: orderId,
            amount: orderData['amount'],
            dataTime: DateTime.parse(orderData['dataTime']),
            products: (orderData['products'] as List<dynamic>)
                .map((item) => CartItem(
                      id: item['id'],
                      price: item['price'],
                      quntity: item['quntity'],
                      title: item['title'],
                    ))
                .toList(),
          ),
        );
      });
      _orders = loadedOrders.reversed.toList();
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addOrder(List<CartItem> cartProduct, double total) async {
    final url =
        'https://e-commerce-e14cd-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken';
    try {
      final timestamp = DateTime.now();
      final res = await http.post(url,
          body: json.encode({
            'amount': total,
            'dataTime': timestamp.toIso8601String(),
            'products': cartProduct
                .map((cp) => {
                      'id': cp.id,
                      'title': cp.title,
                      'quantity': cp.quntity,
                      'price': cp.price,
                    })
                .toList(),
          }));

      _orders.insert(
          0,
          OrderItem(
            id: json.decode(res.body)['name'],
            amount: total,
            dataTime: timestamp,
            products: cartProduct,
          ));
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
