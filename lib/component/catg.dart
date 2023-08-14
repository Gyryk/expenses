import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Category extends StatelessWidget {
  final String amount;
  final String category;

  Category({super.key, required this.amount, required this.category});

  @override
  Widget build(BuildContext context) {
    const title = TextStyle(
        color: Colors.white, fontWeight: FontWeight.w300, fontSize: 22);
    const price = TextStyle(
        color: Colors.white, fontWeight: FontWeight.w400, fontSize: 18);

    return ListTile(
        title: Text(category, style: title),
        trailing: Text('£$amount', style: price));
  }
}
