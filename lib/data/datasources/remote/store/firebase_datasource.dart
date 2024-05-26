import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pos/data/models/store.dart';

import '../../../../core/core.dart';
import 'datasource.dart';

class StoreFBRemoteDatasourceImpl implements StoreRemoteDatasource {

  late CollectionReference _reference;

  StoreFBRemoteDatasourceImpl() {
    _reference = FirestorePath.userPath;
  }

  @override
  Future<bool> addStore(String userID, StoreModel store) => _reference.doc(userID).collection("stores").doc(store.id).set(store.toJson()).then((res) {
    return true;
  }).catchError((err) {
    return false;
  });

  @override
  Future<bool> deleteStore(String userID, String storeID) => _reference.doc(userID).collection("stores").doc(storeID).delete().then((res) {
    return true;
  }).catchError((err) {
    return false;
  });

  @override
  Future<bool> editStore(String userID, String storeID, StoreModel store) => _reference.doc(userID).collection("stores").doc(storeID).update(store.toJson()).then((res) {
    return true;
  }).catchError((err) {
    return false;
  });

  @override
  Future<StoreModel?> getStore(String userID, String storeID) => _reference.doc(userID).collection("stores").doc(storeID).get().then((res) {
    if (res.exists) {
      return StoreModel.fromJson(res.data() as Map<String, dynamic>);
    }
    return null;
  }).catchError((err) {
    return null;
  });

  @override
  Future<List<StoreModel>?> getStoresList(String userID) async {
    try {
      final storesCollection = _reference.doc(userID).collection("stores");
      QuerySnapshot querySnapshot = await storesCollection.get();

      List<StoreModel> data = [];

      for (var doc in querySnapshot.docs) {
        data.add(StoreModel.fromJson(doc.data() as Map<String, dynamic>));
      }

      return data;
    } catch (e) {
      throw Exception("Gagal mengambil list store");
    }
  }

}