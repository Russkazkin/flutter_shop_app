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

  void addProduct() {
    //_items.add(value);
    notifyListeners();
  }
}