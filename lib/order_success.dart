import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class order_success_screen extends StatelessWidget {
  final String productName;
  order_success_screen({super.key, required this.productName});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Order placed successfully'),
            Text("Product Name : $productName"),

          ],
        ),
      ),
    );
  }
}
