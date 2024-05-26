import 'package:cloud_firestore/cloud_firestore.dart';

class FirestorePath {
  static CollectionReference get userPath => FirebaseFirestore.instance.collection('users');
  static CollectionReference storePath(String userID) => FirebaseFirestore.instance.collection('users').doc(userID).collection('stores');
  static CollectionReference productPath(String userID, String storeID) => FirebaseFirestore.instance.collection('users').doc(userID).collection('stores').doc(storeID).collection('products');
}