import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/providers/product_cart_provider.dart';

class alert_cart_delete extends StatelessWidget {
  const alert_cart_delete({
    super.key,
    required this.cartItem,
  });

  final Map<String, dynamic> cartItem;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Confirm Delete",
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      content: const Text("Are you sure to delete this item in your cart?"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlue,
                  fontSize: 18),
            )),
        TextButton(
            onPressed: () {
              Provider.of<CartProvider>(context, listen: false)
                  .removeProduct(cartItem);
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  duration: Duration(milliseconds: 800),
                  content: Text('Product removed from cart!'),
                ),
              );
            },
            child: const Text(
              'Yes',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.red, fontSize: 18),
            )),
      ],
    );
  }
}
