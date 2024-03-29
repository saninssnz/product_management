import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:machine_test/src/data/models/product_model.dart';
import 'package:qr_flutter/qr_flutter.dart';

Future<User?> createAccount(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  } catch (e) {
    if (kDebugMode) {
      print("Error creating account: $e");
    }
    return null;
  }
}


Future<User?> signIn(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  } catch (e) {
    if (kDebugMode) {
      print("Error signing in: $e");
    }
    return null;
  }
}


Future<void> addProduct(String productName, String measurement, double price) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    throw Exception('Must be logged in to add products');
  }

  final product = {
    'productName': productName,
    'measurement': measurement,
    'price': price,
    'addedByUserId': user.uid,
  };

  await FirebaseFirestore.instance.collection('products').add(product);
}


Future<List<Product>> fetchProducts() async {
  if (kDebugMode) {
    print("Fetching products...");
  }
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('products').get();
  final products = querySnapshot.docs.map((doc) => Product.fromFirestore(doc)).toList();
  if (kDebugMode) {
    print("Fetched ${products.length} products.");
  }
  return products;
}

