import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  Future<void> addProduct(Product product) {
    final url = Uri.parse('https://flutter-shop-1ef5f-default-rtdb.firebaseio.com/products.json');
    return http.post(url, body: json.encode({
      'title': product.title,
      'description': product.description,
      'price': product.price,
      'imageUrl': product.imageUrl,
      'isFavorite': product.isFavorite,
    })).then((response) {
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        isFavorite: product.isFavorite,
      );
      _items.add(newProduct);
      notifyListeners();
    }).catchError((error) {
      throw error;
    });
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
