import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' as OrdersProvider;
import '../widget/order_item.dart';

class Orders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<OrdersProvider.Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: ListView.builder(
        itemCount: data.orders.length,
        itemBuilder: (context, index) => OrderItem(data.orders[index]),
      ),
    );
  }
}
