import 'package:flutter/material.dart';
import 'package:lesson08/models/product_model.dart';
import 'package:lesson08/widgets/product_form.dart';

class ProductPopup extends StatelessWidget {
  final ProductModel? product;
  ProductPopup({this.product});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          color: Colors.white,
        ),
        height: MediaQuery.of(context).size.height * 0.3,
        child: ProductForm(
          product: product,
        ),
      ),
    );
  }
}
