import 'package:ecommerce/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user-product';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('UserProductScreen')),
      body: Center(child: Text('UserProductScreen')),
      drawer: AppDrawer(),
    );
  }
}
