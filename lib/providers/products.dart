import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];
  final url = Uri.parse(
      'https://flutter-shop-1ef5f-default-rtdb.firebaseio.com/products.json');

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      data.forEach((productId, productData) {
        loadedProducts.add(Product(
            id: productId,
            title: productData['title'],
            imageUrl: productData['imageUrl'],
            description: productData['description'],
            price: productData['price'],
            isFavorite: productData['isFavorite']));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'isFavorite': product.isFavorite,
          }));
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
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product product) async {
    final productIndex = _items.indexWhere((product) => product.id == id);
    if (productIndex >= 0) {
      final productUrl = Uri.parse(
          'https://flutter-shop-1ef5f-default-rtdb.firebaseio.com/products/$id.json');
      await http.patch(productUrl,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
          }));
      _items[productIndex] = product;
      notifyListeners();
    } else {
      print('No products to update');
    }
  }

  void deleteProduct(String id) {
    final existingProductIndex =
        _items.indexWhere((Product product) => product.id == id);
    var existingProduct = _items[existingProductIndex];
    final productUrl = Uri.parse(
        'https://flutter-shop-1ef5f-default-rtdb.firebaseio.com/products/$id.json');
    _items.removeAt(existingProductIndex);
    notifyListeners();
    http.delete(productUrl).then((response) {
      if (response.statusCode >= 400) {
        throw Exception('Something went wrong!');
      }
      existingProduct = null;
    }).catchError((_) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
    });
  }
}
