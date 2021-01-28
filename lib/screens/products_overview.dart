import 'package:flutter/material.dart';

import '../data/products.dart';
import '../models/product.dart';

class ProductsOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) => Container(),
        padding: const EdgeInsets.all(10),
        itemCount: dummyProduct.length,
      ),
    );
  }
}
