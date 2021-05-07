import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

import 'providers/orders.dart';
import 'providers/auth.dart';
import 'providers/cart.dart';
import 'screens/product_detail.dart';
import 'screens/products_overview.dart';
import 'providers/products.dart';
import 'screens/cart.dart' as CartScreen;
import 'screens/orders.dart' as OrdersScreen;
import 'screens/user_products.dart';
import 'screens/edit_product_screen.dart';
import 'screens/auth_screen.dart';

Future main() async {
  await DotEnv.load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: null,
          update: (context, auth, previousProducts) => Products(
            auth.token,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orders(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (builderContext, auth, _) => MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          home: auth.isAuth ? ProductsOverview() : AuthScreen(),
          routes: {
            ProductDetail.route: (context) => ProductDetail(),
            CartScreen.Cart.route: (context) => CartScreen.Cart(),
            OrdersScreen.Orders.route: (context) => OrdersScreen.Orders(),
            UserProducts.route: (context) => UserProducts(),
            EditProductScreen.route: (context) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
