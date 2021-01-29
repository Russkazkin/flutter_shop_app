import 'package:flutter/material.dart';

import '../data/products.dart';
import '../models/product.dart';
import '../widget/product_item.dart';

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
        itemBuilder: (context, index) => ProductItem(
          id: dummyProduct[index].id,
          title: dummyProduct[index].title,
          imageUrl: dummyProduct[index].imageUrl,
        ),
        padding: const EdgeInsets.all(10),
        itemCount: dummyProduct.length,
      ),
    );
  }
}
