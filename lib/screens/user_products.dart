import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class UserProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // ...
            },
          ),
        ],
      ),
      body: Padding(padding: EdgeInsets.all(8), child: ListView.builder(itemCount: products.items.length, itemBuilder: (_, index) => ,),),
    );
  }
}
