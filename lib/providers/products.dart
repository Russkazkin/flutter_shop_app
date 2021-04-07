import 'package:flutter/material.dart';

import 'product.dart';
import '../data/products.dart';

class Products with ChangeNotifier {
  List<Product> _items = dummyProduct;

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  void addProduct(Product product) {
    final newProduct = Product(
      id: DateTime.now().toString(),
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      isFavorite: product.isFavorite,
    );
    _items.add(newProduct);
    notifyListeners();
  }

  void updateProduct(String id, Product product) {
    final productIndex = _items.indexWhere((product) => product.id == id);
    if (productIndex >= 0) {
      _items[productIndex] = product;
      notifyListeners();
    } else {
      print('No products to update');
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((Product product) => product.id == id);
    notifyListeners();
  }
}
