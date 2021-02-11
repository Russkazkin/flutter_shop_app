import 'package:flutter/material.dart';

import 'product.dart';
import '../data/products.dart';

class Products with ChangeNotifier {
  var _showFavoritesOnly = false;

  List<Product> _items = dummyProduct;

  List<Product> get items {
    if(_showFavoritesOnly) {
      return _items.where((product) => product.isFavorite).toList();
    }
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  void showFavoritesOnly() {
    _showFavoritesOnly = true;
    notifyListeners();
  }

  void showAll() {
    _showFavoritesOnly = false;
    notifyListeners();
  }

  void addProduct() {
    //_items.add(value);
    notifyListeners();
  }
}