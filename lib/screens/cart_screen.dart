import 'package:ecommerce/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart';
import '../widgets/cart_item.dart' as c;

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text('Your Cart')),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15.0),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),

                  // بيدي مساحه
                  Spacer(),

                  // total اللي بيظهر ف السعر
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.headline6.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),

                  //order button
                  OrderButton(cart: cart),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, int index) => c.CartItem(
                cart.items.values.toList()[index].id,
                cart.items.keys.toList()[index], // productId
                cart.items.values.toList()[index].price,
                cart.items.values.toList()[index].quntity,
                cart.items.values.toList()[index].title,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  final Cart cart;

  const OrderButton({
    @required this.cart,
  });
  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: _isLoading ? CircularProgressIndicator() : Text('ORDER NOW'),
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<Orders>(context, listen: false).addOrder(
                widget.cart.items.values.toList(),
                widget.cart.totalAmount,
              );
              setState(() {
                _isLoading = false;
              });
              widget.cart.clear(); //clear بتعمل cart معموله في ال function في
            },
      style: TextButton.styleFrom(primary: Theme.of(context).primaryColor),
    );
  }
}
