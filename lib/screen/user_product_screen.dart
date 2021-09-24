import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/products_provider.dart';
import 'package:shopapp/screen/edit_product_screen.dart';
import 'package:shopapp/widget/app_drawer.dart';
import 'package:shopapp/widget/user_items.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = 'user-product-screen';

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Product'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
            icon: Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (ctx, i) => Column(
          children: [
            UserItem(
              id: productData.items[i].id,
              title: productData.items[i].title,
              imageUrl: productData.items[i].imageUrl,
            ),
            Divider(),
          ],
        ),
        itemCount: productData.items.length,
      ),
      drawer: AppDrawer(),
    );
  }
}
