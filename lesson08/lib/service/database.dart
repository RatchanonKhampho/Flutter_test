import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lesson08/models/product_model.dart';

class Database {
  static Database instance = Database._();
  Database._();
  Stream<List<ProductModel>> getAllProductStream() {
    final reference = FirebaseFirestore.instance.collection('products');
    Query query = reference.orderBy('id', descending: true);
    final snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      return snapshot.docs.map((doc) {
        return ProductModel.fromMap(doc.data() as Map<String, dynamic>?);
      }).toList();
    });
  }

  Future<void> setProduct({required ProductModel product}) async {
    final reference = FirebaseFirestore.instance.doc('products/${product.id}');
    try {
      await reference.set(product.toMap());
    } catch (err) {
      rethrow;
    }
  }

  Future<void> deleteProduct({required ProductModel product}) async {
    final reference = FirebaseFirestore.instance.doc('products/${product.id}');
    try {
      await reference.delete();
    } catch (err) {
      rethrow;
    }
  }
}
