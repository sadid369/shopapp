import 'package:flutter/material.dart';
import 'package:shopapp/providers/product.dart';
import 'package:shopapp/widget/product_item.dart';
import 'package:shopapp/widget/products_grid.dart';

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
        ],
        title: Text('MyShop'),
      ),
      body: ProductsGrid(
        _showOnlyFavorite,
      ),
    );
  }
}
