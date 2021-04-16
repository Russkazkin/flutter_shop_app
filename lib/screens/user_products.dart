import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widget/user_product_item.dart';
import '../widget/app_drawer.dart';
import '../screens/edit_product_screen.dart';

class UserProducts extends StatelessWidget {
  static const route = '/user-products';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchProducts();
  }

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
              Navigator.of(context).pushNamed(EditProductScreen.route);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: products.items.length,
            itemBuilder: (_, index) => Column(
              children: [
                UserProductItem(
                  id: products.items[index].id,
                  title: products.items[index].title,
                  imageUrl: products.items[index].imageUrl,
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
