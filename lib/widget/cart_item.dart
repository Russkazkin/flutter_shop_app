import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  const CartItem(
      {Key key, this.id, this.price, this.quantity, this.title, this.productId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) => showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text('Are you sure?'),
          content: Text('Do you want to remove the item from the cart?'),
          actions: [
            FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('No'),
            ),
            FlatButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Yes'),
            ),
          ],
        ),
      ),
      key: key,
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white70,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        margin: EdgeInsets.only(right: 16, top: 4, bottom: 4),
        padding: EdgeInsets.only(right: 16),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: FittedBox(
                  child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text('\$$price'),
              )),
            ),
            title: Text(title),
            subtitle: Text('Total: \$${price * quantity}'),
            trailing: Text('$quantity pcs'),
          ),
        ),
      ),
    );
  }
}
