import 'package:shared_preferences/shared_preferences.dart';
import '../models/http_exception.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavorite = false});

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

// Fuction for add and remove product for favorite
  Future<void> toggleFavoriteStatus(String token, String userId) async {
    final oldStatus = isFavorite; // old favorite saved
    isFavorite = !isFavorite;
    notifyListeners();

    final url =
        'https://e-commerce-e14cd-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';
    // url from backend
    try {
      final res = await http.put(url,
          body: json.encode(isFavorite)); // to change one value
      if (res.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (e) {
      _setFavValue(oldStatus);
    }
  }
}
