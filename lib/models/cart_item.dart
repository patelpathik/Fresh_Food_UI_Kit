import 'package:flutter/cupertino.dart';

class CartItem {
  final String imagePath;
  final String text;
  final String quantity;
  final String price;

  CartItem({
    @required this.imagePath,
    @required this.text,
    @required this.quantity,
    @required this.price,
  });
}
