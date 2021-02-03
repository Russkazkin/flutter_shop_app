import 'package:flutter/material.dart';

import '../screens/product_detail.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final double price;
  final String imageUrl;

  const ProductItem({this.id, this.title, this.price, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetail.route,
              arguments: id,
            );
          },
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        header: GridTileBar(
          title: Text(
            title,
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black38,
        ),
        footer: GridTileBar(
          leading: IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
            color: Theme.of(context).accentColor,
          ),
          backgroundColor: Colors.black87,
          title: Text(
            '\$$price',
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart_rounded),
            onPressed: () {},
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
