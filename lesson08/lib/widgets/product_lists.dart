import 'package:flutter/material.dart';
import 'package:lesson08/models/product_model.dart';
import 'package:lesson08/service/database.dart';
import 'package:lesson08/widgets/product_item.dart';

class ProductLists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Database db = Database.instance;
    Stream<List<ProductModel>> stream = db.getAllProductStream();
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: StreamBuilder<List<ProductModel>>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.length == 0) {
              return Center(child: Text('ยังไม่มีข้อมูลสินค้า'));
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  child: ProductItem(product: snapshot.data![index]),
                  onDismissed: (direction) {
                    if (direction == DismissDirection.endToStart) {
                      db.deleteProduct(product: snapshot.data![index]);
                    }
                  },
                  background:
                      Container(color: Color.fromARGB(255, 54, 131, 194)),
                  direction: DismissDirection.endToStart,
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
