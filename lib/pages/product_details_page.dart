import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/global_variable.dart';
import 'package:shopping_app/pages/home_page.dart';
import 'package:shopping_app/providers/product_cart_provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String, dynamic> product;
  const ProductDetailsPage({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late int currentSize;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentSize = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Details',
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const HomePage(
                    currentPage: 1,
                  ),
                ));
              },
              icon: const Icon(Icons.shopping_cart))
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.product['title'],
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Spacer(),
            Image(
              image: AssetImage(widget.product['imageUrl']),
              height: 400,
            ),
            const Spacer(
              flex: 2,
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(245, 247, 249, 1),
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              height: 250,
              child: Column(
                children: [
                  const Spacer(),
                  Text('\$${widget.product['price'].toString()}',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 54,
                    width: double.infinity,
                    child: FractionallySizedBox(
                      widthFactor: 0.9,
                      heightFactor: 1,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.product['sizes'].length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                currentSize = widget.product['sizes'][index];
                                // print(currentSize);
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                  color: widget.product['sizes'][index] ==
                                          currentSize
                                      ? Theme.of(context).colorScheme.primary
                                      : Colors.white,
                                  border: Border.all(color: Colors.black45),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12))),
                              child: Text(
                                widget.product['sizes'][index].toString(),
                                style: const TextStyle(color: Colors.black45),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        if (currentSize != 0) {
                          Provider.of<CartProvider>(context, listen: false)
                              .addProduct({
                            'id': widget.product['id'],
                            'title': widget.product['title'],
                            'company': widget.product['company'],
                            'price': widget.product['price'],
                            'size': currentSize,
                            'imageUrl': widget.product['imageUrl']
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              duration: Duration(milliseconds: 800),
                              content: Text('Product added to cart!'),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select a size!'),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(12),
                          foregroundColor: Colors.black,
                          backgroundColor: Theme.of(context).primaryColor,
                          // maximumSize: const Size(400, 400), // rather than create min and max size, we create fix size for button.
                          fixedSize: const Size(350, 50)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Add to Cart',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
