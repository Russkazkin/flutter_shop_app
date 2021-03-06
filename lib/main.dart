import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/orders.dart';
import 'providers/cart.dart';
import 'screens/product_detail.dart';
import 'screens/products_overview.dart';
import 'providers/products.dart';
import 'screens/cart.dart' as CartScreen;
import 'screens/orders.dart' as OrdersScreen;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orders(),
        ),
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: ProductsOverview(),
        routes: {
          ProductDetail.route: (context) => ProductDetail(),
          CartScreen.Cart.route: (context) => CartScreen.Cart(),
          OrdersScreen.Orders.route: (context) => OrdersScreen.Orders(),
        },
      ),
    );
  }
}
