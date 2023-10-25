import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/widgets/product_cart.dart';
import 'package:shopping_app/widgets/product_list.dart';

class HomePage extends StatefulWidget {
  final currentPage;
  const HomePage({super.key, this.currentPage = 0});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> tab = [
    const ProductListTab(),
    const ProductCartTab(),
  ];
  late int currentPage;
  @override
  void initState() {
    // TODO: implement initState
    currentPage = widget.currentPage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: IndexedStack(
        index: currentPage,
        children: tab,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: currentPage,
        items: const [
          Icon(
            Icons.home,
            size: 36,
          ),
          Icon(
            Icons.shopping_cart_rounded,
            size: 36,
          )
        ],
        height: 50,
        backgroundColor: Theme.of(context).colorScheme.primary,
        buttonBackgroundColor: Theme.of(context).colorScheme.primary,
        animationDuration: const Duration(milliseconds: 500),
        animationCurve: Curves.ease,
        onTap: (value) {
          setState(() {
            currentPage = value;
          });
        },
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //     iconSize: 35,
      //     selectedFontSize: 0,
      //     unselectedFontSize: 0,
      //     currentIndex: currentPage,
      //     onTap: (value) {
      //       setState(() {
      //         currentPage = value;
      //       });
      //     },
      //     items: const [
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.home),
      //         label: '',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.shopping_cart_outlined),
      //         label: '',
      //       )
      //     ]),
    );
  }
}
