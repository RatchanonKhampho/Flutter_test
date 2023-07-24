import 'package:flutter/material.dart';
import 'package:lesson08/models/product_model.dart';
import 'package:lesson08/service/database.dart';

class ProductForm extends StatefulWidget {
  final ProductModel? product;
  ProductForm({this.product});
  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  Database db = Database.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      nameController.text = widget.product!.productName;
      priceController.text = widget.product!.price.toString();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.product != null
              ? 'แก้ไข ${widget.product!.productName}'
              : 'เพิ่มสินค้าใหม่'),
          TextField(
            controller: nameController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: 'ชื่อสินค้า'),
          ),
          TextField(
            controller: priceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'ราคาสินค้า'),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _showOKButton(),
              SizedBox(
                width: 10,
              ),
              _showCancelButton(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _showOKButton() {
    return TextButton(
      onPressed: () async {
        String newProductId =
            'PD${DateTime.now().millisecondsSinceEpoch.toString()}';
        await db.setProduct(
          product: ProductModel(
            id: widget.product == null ? newProductId : widget.product!.id,
            productName: nameController.text,
            price: double.tryParse(priceController.text) ?? 0,
          ),
        );
        nameController.clear();
        priceController.clear();
        Navigator.of(context).pop();
      },
      child: Text(widget.product == null ? 'เพิ่ม' : 'แก้ไข'),
    );
  }

  Widget _showCancelButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text('ปิด'),
    );
  }
}
