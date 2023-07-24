// import 'package:flutter/material.dart';
class ProductModel {
  String id;
  String productName;
  dynamic price;
  ProductModel({
    required this.id,
    required this.productName,
    required this.price,
  });
  factory ProductModel.fromMap(Map<String, dynamic>? product) {
    if (product != null) {
      String id = product['id'];
      String productName = product['productName'];
      dynamic price = product['price'];
      return ProductModel(
        id: id,
        productName: productName,
        price: price,
      );
    } else {
      throw ArgumentError('Unexpected type for product');
    }
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productName': productName,
      'price': price,
    };
  }
}
