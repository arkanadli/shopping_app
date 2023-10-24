import 'package:flutter/material.dart';
import 'package:shopping_app/components/product_card.dart';
import '../global_variable.dart';

class ProductListTab extends StatefulWidget {
  const ProductListTab({super.key});

  @override
  State<ProductListTab> createState() => _ProductListTabState();
}

class _ProductListTabState extends State<ProductListTab> {
  final List<String> listFilter = const [
    'All',
    'Adidas',
    'Nike',
    'Puma',
    'Reebok',
  ];
  late String selectedFilter;
  late var productsFiltered;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedFilter = listFilter[0];
    productsFiltered = products;
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size; // this is inherited widget
    final size = MediaQuery.sizeOf(context); // this is inherited model
    // we using the inherited model to reduce any other feature in widget that might be change
    // whether it is the pixel ratio or etc. It will causing something like rebuild unnecassary.

    return SafeArea(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Shoes\nCollection',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const Expanded(
                child: TextField(
                  style: TextStyle(
                    // color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 1)),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                        topLeft: Radius.circular(32),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(225, 225, 225, 1)),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                        topLeft: Radius.circular(32),
                      ),
                    ),
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 100,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: listFilter.length,
              itemBuilder: (context, index) {
                final filter = listFilter[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: GestureDetector(
                    onTap: () {
                      selectedFilter = filter;
                      if (filter != 'All') {
                        productsFiltered = products
                            .where((product) =>
                                product['company'] == selectedFilter)
                            .toList();
                      } else {
                        productsFiltered = products;
                      }
                      setState(() {});
                    },
                    child: Chip(
                      label: Text(
                        listFilter[index],
                        style: const TextStyle(fontSize: 16),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      backgroundColor: selectedFilter == filter
                          ? Theme.of(context).colorScheme.primary
                          : const Color.fromARGB(255, 238, 242, 245),
                      side: const BorderSide(
                        color: Color.fromRGBO(247, 250, 253, 1),
                      ),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                  ),
                );
              },
            ),
          ),
          // we are using layout builder
          // it is a flutter widget that provides constrains condition to printout some layout.
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                print(constraints.maxWidth);
                if (constraints.maxWidth >= 1080) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 0,
                            childAspectRatio: 1.6),
                    itemCount: productsFiltered.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ProductCard(index: index, product: product);
                    },
                  );
                } else {
                  return ListView.builder(
                    itemCount: productsFiltered.length,
                    itemBuilder: ((context, index) {
                      final product = productsFiltered[index];
                      return SizedBox(
                        height: 300,
                        child: ProductCard(
                          index: index,
                          product: product,
                        ),
                      );
                    }),
                  );
                }
              },
            ),
          ),
          // :: here is coding for
          // Expanded(
          //   // return type of widgets that responsive to web or mobile
          //   child: size.width >= 1080
          //       // a same like listview but have cross axis count that can enabling more than 1 card in one row
          //       ? GridView.builder(
          //           gridDelegate:
          //               const SliverGridDelegateWithFixedCrossAxisCount(
          //                   crossAxisCount: 2,
          //                   mainAxisSpacing: 0,
          //                   childAspectRatio: 1.9),
          //           itemCount: productsFiltered.length,
          //           itemBuilder: (context, index) {
          //             final product = products[index];
          //             return ProductCard(index: index, product: product);
          //           },
          //         )
          //       : ListView.builder(
          //           itemCount: productsFiltered.length,
          //           itemBuilder: ((context, index) {
          //             final product = productsFiltered[index];
          //             return ProductCard(
          //               index: index,
          //               product: product,
          //             );
          //           }),
          //         ),
          // ),
        ],
      ),
    );
  }
}
