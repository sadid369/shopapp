import 'package:flutter/material.dart';
import 'package:shopapp/providers/cart.dart';
import 'package:shopapp/providers/product.dart';
import 'package:shopapp/screen/cart_screen.dart';
import 'package:shopapp/widget/badge.dart';
import 'package:shopapp/widget/product_item.dart';
import 'package:shopapp/widget/products_grid.dart';
import 'package:provider/provider.dart';

enum FilterOption {
  Favorites,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            onSelected: (FilterOption selectedValue) {
              setState(() {
                if (selectedValue == FilterOption.Favorites) {
                  _showOnlyFavorite = true;
                } else {
                  _showOnlyFavorite = false;
                }
              });
              print(selectedValue);
              print(_showOnlyFavorite);
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('FavoriteItem')
                  ],
                ),
                value: FilterOption.Favorites,
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(
                      Icons.home,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('All Item')
                  ],
                ),
                value: FilterOption.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (ctx, cart, ch) => Badge(
                child: ch!,
                value: cart.itemCount.toString(),
                color: Theme.of(context).accentColor),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              icon: Icon(Icons.shopping_cart),
            ),
          ),
        ],
        title: Text('MyShop'),
      ),
      body: ProductsGrid(
        _showOnlyFavorite,
      ),
    );
  }
}
