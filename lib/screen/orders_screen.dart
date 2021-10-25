import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/orders.dart' show Orders;
import 'package:shopapp/widget/app_drawer.dart';
import 'package:shopapp/widget/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/order';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Future? _orderFuture;
  Future _obtainOrderFuture() {
    return Provider.of<Orders>(context, listen: false).fatchAndSetOrders();
  }

  @override
  void initState() {
    _orderFuture = _obtainOrderFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Order',
        ),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
          future:
              _orderFuture,
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (dataSnapshot.error != null) {
                return Center(
                  child: Text('An Error occurred'),
                );
              } else {
                return Consumer<Orders>(
                  builder: (ctx, orderData, child) => ListView.builder(
                    itemCount: orderData.order.length,
                    itemBuilder: (ctx, i) => OrderItem(
                      order: orderData.order[i],
                    ),
                  ),
                );
              }
            }
          }),
    );
  }
}
