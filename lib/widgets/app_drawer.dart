import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/orders_screen.dart';
import '../screens/user_products_screen.dart';
import '../providers/auth.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hi!'),
            automaticallyImplyLeading: false,
            // بيشيل الخطوط للي فوق بعض
          ),
          Divider(),
          // sizedbox شبه ال
          ListTile(
            leading: Icon(Icons.shop),
            // الحته اليمين للي ف الاب باار
            title: Text('Shop'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/'),
            // product overview screen بينقلني للصفحه الرئيسيه او
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(OrderScreen.routeName),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Product'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(UserProductScreen.routeName),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              //widget of drawer هتشيل
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).logout();
              // فانكشن جاهزة علشان اعمل منها تسجيل خروج
            },
          ),
        ],
      ),
    );
  }
}
