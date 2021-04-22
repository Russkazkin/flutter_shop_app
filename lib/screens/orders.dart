import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' as OrdersProvider;
import '../widget/order_item.dart';
import '../widget/app_drawer.dart';

class Orders extends StatefulWidget {
  static const route = '/orders';

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      Provider.of<OrdersProvider.Orders>(context, listen: false).fetchOrders();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<OrdersProvider.Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: data.orders.length,
        itemBuilder: (context, index) => OrderItem(data.orders[index]),
      ),
    );
  }
}
