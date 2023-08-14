import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Month extends StatelessWidget {
  final String amount;
  final String category;
  final String month;

  Month(
      {super.key,
      required this.amount,
      required this.category,
      required this.month});

  @override
  Widget build(BuildContext context) {
    const title = TextStyle(
        color: Colors.white, fontWeight: FontWeight.w300, fontSize: 21);
    const price = TextStyle(
        color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17);
    const categ = TextStyle(
        color: Colors.white, fontWeight: FontWeight.w200, fontSize: 13);

    return ListTile(
      title: Text(month, style: title),
      trailing: RichText(
          text: TextSpan(children: [
            TextSpan(text: '£$amount', style: price),
            TextSpan(text: '\n$category', style: categ)
          ]),
          textAlign: TextAlign.right),
    );
  }
}
