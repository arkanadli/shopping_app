import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> cart = [];

  void addProduct(Map<String, dynamic> product) {
    cart.add(product);
    notifyListeners(); // notify if this function had been called to any widget that listening to this Provider
  }

  void removeProduct(Map<String, dynamic> product) {
    cart.remove(product);
    notifyListeners(); // notify if this function had been called to any widget that listening to this Provider
  }
}
