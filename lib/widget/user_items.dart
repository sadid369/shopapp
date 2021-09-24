import 'package:flutter/material.dart';
import 'package:shopapp/providers/products_provider.dart';

import 'package:shopapp/screen/edit_product_screen.dart';
import 'package:provider/provider.dart';

class UserItem extends StatelessWidget {
  final String? id;
  final String title;
  final String imageUrl;
  const UserItem({
    Key? key,
    required this.id,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: id);
              },
              icon: Icon(
                Icons.edit,
              ),
            ),
            IconButton(
              onPressed: () {
                Provider.of<Products>(context, listen: false).removeProduct(id!);
              },
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
