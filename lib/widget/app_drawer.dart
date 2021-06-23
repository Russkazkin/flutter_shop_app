import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../screens/orders.dart';
import '../screens/user_products.dart';
import '../helpers/custom_route.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hello Friend!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shopping_bag_sharp),
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(Orders.route);
              // Navigator.of(context).pushReplacement(
              //   CustomRoute(
              //     builder: (builderContext) => Orders(),
              //   ),
              // );
            },
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage products'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(UserProducts.route);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app_rounded),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
