import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pos/core/core.dart';
import 'package:pos/data/datasources/datasources.dart';
import 'package:pos/data/models/user.dart';

class UserFBRemoteDatasource implements UserRemoteDatasource {

  late CollectionReference _reference;

  UserFBRemoteDatasource() {
    _reference = FirestorePath.userPath;
  }

  @override
  Future<UserModel> getUserData(String userID) async {
    try {
      final snapshot = await _reference.doc(userID).get();

      if(snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        print("#### User: $data");

        return UserModel.fromJson(data);
      }

      throw Exception();

    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<bool> saveUserData(UserModel user) => _reference.doc(user.uid).set(user.toJson()).then((res) {
  return true;
  }).catchError((error) {
  return false;
  });
}