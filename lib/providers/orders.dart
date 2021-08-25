import 'package:flutter/material.dart';

import 'package:shopapp/providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _order = [];
  List<OrderItem> get order {
    return [..._order];
  }

  void addOrder(List<CartItem> cartProduct, double total) {
    _order.insert(
        0,
        OrderItem(
          id: DateTime.now().toString(),
          amount: total,
          dateTime: DateTime.now(),
          products: cartProduct,
        ));
    notifyListeners();
  }
}
