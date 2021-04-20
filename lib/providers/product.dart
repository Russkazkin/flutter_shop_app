import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/http_exception.dart';

class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavoriteStatus() async {
    final productUrl = Uri.parse(
        'https://flutter-shop-1ef5f-default-rtdb.firebaseio.com/products/$id.json');
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final response = await http.patch(productUrl, body: jsonEncode({
      'isFavorite': isFavorite
    }));
    if (response.statusCode >= 400) {
      isFavorite = oldStatus;
      notifyListeners();
      throw HttpException('Could not change favorite status.');
    }
  }
}
