import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/global_variable.dart';
import 'package:shopping_app/components/alert_cart_delete.dart';
import 'package:shopping_app/providers/product_cart_provider.dart';

class ProductCartTab extends StatefulWidget {
  const ProductCartTab({super.key});

  @override
  State<ProductCartTab> createState() => _ProductCardTabState();
}

class _ProductCardTabState extends State<ProductCartTab> {
  @override
  Widget build(BuildContext context) {
    // :: we use the shorthand syntax
    // final cartList = Provider.of<CartProvider>(context).cart;
    final cartList = context.watch<CartProvider>().cart;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: ListView.builder(
        itemCount: cartList.length,
        itemBuilder: (context, index) {
          final cartItem = cartList[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(cartItem['imageUrl'].toString()),
              radius: 40,
            ),
            trailing: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return alert_cart_delete(cartItem: cartItem);
                      
                    },
                  );
                  
                },
                icon: const Icon(
                  Icons.delete_forever,
                  color: Colors.red,
                )),
            title: Text(
              cartItem['title'].toString(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            subtitle: Text(
              "Size : ${cartItem['size']}",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          );
        },
      ),
    );
  }
}
