import 'package:flutter/material.dart';

import '../widget/products_grid.dart';

class ProductsOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: [
          PopupMenuButton(
            onSelected: (int selectedValue) {
              print(selectedValue);
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text(
                  'Only Favorites',
                ),
                value: 0,
              ),
              PopupMenuItem(
                child: Text(
                  'Show All',
                ),
                value: 1,
              ),
            ],
            icon: Icon(
              Icons.more_vert,
            ),
          ),
        ],
      ),
      body: ProductsGrid(),
    );
  }
}
