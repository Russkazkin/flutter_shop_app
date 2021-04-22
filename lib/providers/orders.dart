import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import '../models/CartItem.dart';
import '../models/OrderItem.dart';

class Orders with ChangeNotifier {
  final url = Uri.parse(
      'https://flutter-shop-1ef5f-default-rtdb.firebaseio.com/orders.json');

  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [...this._orders];
  }

  Future<void> fetchOrders() async {
    final response = await http.get(url);
    print(json.decode(response.body));
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final timeStamp = DateTime.now();
    final response = await http.post(url, body: json.encode({
      'amount': total,
      'dateTime': timeStamp.toIso8601String(),
      'products': cartProducts.map((cartProduct) => {
        'id': cartProduct.id,
        'title': cartProduct.title,
        'quantity': cartProduct.quantity,
        'price': cartProduct.price,
      }).toList(),
    }),);
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        dateTime: timeStamp,
        products: cartProducts,
      ),
    );
    notifyListeners();
  }
}
