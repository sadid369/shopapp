import 'package:flutter/material.dart';

import 'package:shopapp/providers/cart.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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

  final String authToken;
  Orders(this.authToken, this._order);
  Future<void> fatchAndSetOrders() async {
    final url =
        'https://shop-app-main-default-rtdb.asia-southeast1.firebasedatabase.app/orders.json?auth=$authToken';
    final response = await http.get(Uri.parse(url));
    print(json.decode(response.body));
    final List<OrderItem> loadedOrders = [];
    final extracted = json.decode(response.body) as Map<String, dynamic>;
    if (extracted == null) {
      return;
    }
    extracted.forEach((orderId, ordertData) {
      loadedOrders.add(OrderItem(
          id: orderId,
          dateTime: DateTime.parse(ordertData['dateTime']),
          amount: ordertData['amount'],
          products: (ordertData['products'] as List<dynamic>)
              .map((item) => CartItem(
                  id: item['id'],
                  title: item['title'],
                  quantity: item['quantity'],
                  price: item['price']))
              .toList()));
    });
    _order = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProduct, double total) async {
    final url =
        'https://shop-app-main-default-rtdb.asia-southeast1.firebasedatabase.app/orders.json?auth=$authToken';
    final timeStamp = DateTime.now();
    final response = await http.post(Uri.parse(url),
        body: json.encode({
          'amount': total,
          'dateTime': timeStamp.toIso8601String(),
          'products': cartProduct
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price,
                  })
              .toList()
        }));
    _order.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          dateTime: timeStamp,
          products: cartProduct,
        ));
    notifyListeners();
  }
}
