import '../widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import '../widgets/order_item.dart';
import '../providers/orders.dart' show Orders;
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/order';

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Future<void> fetchOrders;

  @override
  void initState() {
    super.initState();
    fetchOrders =
        Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Order')),
      drawer: AppDrawer(),
      body: FutureBuilder<void>(
        future: fetchOrders,
        builder: (ctx, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.error != null) {
              return Center(
                child: Text('An error occurred!'),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) => orderData.orders.isEmpty
                    ? Center(child: Text('Orders is empty'))
                    : ListView.builder(
                        itemBuilder: (BuildContext context, int index) =>
                            OrderItem(
                          orderData.orders[index],
                        ),
                        itemCount: orderData.orders.length,
                      ),
              );
            }
          }
        },
      ),
    );
  }
}
