import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class AddProducts extends StatefulWidget {
  const AddProducts({super.key});

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  final TextEditingController _productNamecontroller = TextEditingController();
  final TextEditingController _availableQuantitycontroller =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  post_products() async {
    Future.delayed(Duration(seconds: 0), () {
      AlertDialog alert = AlertDialog(
        content: Row(children: [
          const CircularProgressIndicator(
            backgroundColor: Colors.red,
          ),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Loading...")),
        ]),
      );
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    });

    var url = Uri.parse("https://uiexercise.onemindindia.com/api/Product");
    var data = {
      'productName': _productNamecontroller.text,
      'availableQuantity': int.parse(_availableQuantitycontroller.text),
    };
    print(data);
    print(data.runtimeType);
    print(jsonEncode(data).runtimeType);
    var response = await http.post(
      url,
      body: jsonEncode(data),
      headers: {"Content-Type": "application/json"},
    );
    print('response.statusCode');
    print(response.statusCode);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: const Text("Add Prodcuts"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.1,
                  ),
                  TextFormField(
                    controller: _productNamecontroller,
                    decoration: const InputDecoration(
                      hintText: 'Product Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter value';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  TextFormField(
                    controller: _availableQuantitycontroller,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Available Quantity ',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter value';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        post_products();
                      }
                    },
                    child: const Text('Add Products'),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
