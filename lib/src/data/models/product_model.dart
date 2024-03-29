import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final String measurement;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.measurement,
    required this.price,
  });

  factory Product.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Product(
      id: doc.id,
      name: data['productName'] ?? '',
      measurement: data['measurement'] ?? '',
      price: data['price']?.toDouble() ?? 0.0,
    );
  }
}
