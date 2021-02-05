import 'package:flutter/material.dart';

import '../models/product.dart';
import '../data/products.dart';

class Products with ChangeNotifier {
  List<Product> _items = dummyProduct;

  List<Product> get items {
    return [..._items];
  }

  void addProduct() {
    //_items.add(value);
    notifyListeners();
  }
}