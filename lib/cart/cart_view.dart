import 'package:flutter/material.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text('cart item 1'),
        Text('cart item 2'),
        Text('cart item 3'),
      ],
    );
  }
}
