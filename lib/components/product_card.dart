import 'package:flutter/material.dart';
import 'package:shopping_app/pages/product_details_page.dart';

class ProductCard extends StatelessWidget {
  final int index;
  final Map<String, dynamic> product;

  const ProductCard({super.key, required this.index, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsPage(
                product: product,
              ),
            ));
      },
      child: Card(
        elevation: 4,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        color: (index + 1).isEven
            ? const Color.fromARGB(255, 238, 242, 245)
            : Colors.yellow[200],
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                product['title'],
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                "\$ ${product['price']}",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Expanded(
                child: Center(
                  child: Hero(
                    tag: product['id'],
                    child: Image(
                      image: AssetImage(product['imageUrl']!),
                      fit: BoxFit.fitWidth,
                      width: 400,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
