import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/orders.dart' show Orders;
import 'package:shopapp/widget/app_drawer.dart';
import 'package:shopapp/widget/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/order';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Order',
        ),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orderData.order.length,
        itemBuilder: (ctx, i) => OrderItem(
          order: orderData.order[i],
        ),
      ),
    );
  }
}
