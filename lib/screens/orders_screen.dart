import 'package:ecommerce/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/order';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('OrderScreen')),
      body: Center(child: Text('OrderScreen')),
      drawer: AppDrawer(),
    );
  }
}
