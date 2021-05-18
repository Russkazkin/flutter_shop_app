import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'product.dart';
import '../models/http_exception.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];

  final String authToken;
  final String userId;

  Products(this.authToken, this.userId, this._items);

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> fetchProducts([bool filterByUser = false]) async {
    final filterString = filterByUser ? 'orderBy="userId"&equalTo="$userId"' : '';
    var url = Uri.parse(
        'https://flutter-shop-1ef5f-default-rtdb.firebaseio.com/products.json?auth=$authToken&$filterString');
    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      if (data == null) {
        return;
      }
      url = Uri.parse(
          'https://flutter-shop-1ef5f-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$authToken');
      final favoritesResponse = await http.get(url);
      final favoriteData = json.decode(favoritesResponse.body);
      data.forEach((productId, productData) {
        loadedProducts.add(
          Product(
            id: productId,
            title: productData['title'],
            imageUrl: productData['imageUrl'],
            description: productData['description'],
            price: productData['price'],
            isFavorite: favoriteData == null ? false : favoriteData[productId] ?? false,
          ),
        );
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
        'https://flutter-shop-1ef5f-default-rtdb.firebaseio.com/products.json?auth=$authToken');
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'userId': userId,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
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
          'https://flutter-shop-1ef5f-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken');
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

  Future<void> deleteProduct(String id) async {
    final existingProductIndex =
        _items.indexWhere((Product product) => product.id == id);
    var existingProduct = _items[existingProductIndex];
    final productUrl = Uri.parse(
        'https://flutter-shop-1ef5f-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken');
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(productUrl);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
  }
}
