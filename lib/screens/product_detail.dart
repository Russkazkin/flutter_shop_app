import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  final String title;

  const ProductDetail({this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
    );
  }
}
