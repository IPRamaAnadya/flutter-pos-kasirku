import 'package:pos/data/datasources/datasources.dart';
import 'package:pos/data/models/models.dart';

import '../../../domain/entities/entities.dart';

abstract class UserRepository {
  Future<UserEntity> getUserData(String userID);
  Future<bool> saveUserData(UserEntity userID);
}

class UserRepositoryImpl implements UserRepository {

  final UserRemoteDatasource _remote;
  UserRepositoryImpl(this._remote);

  @override
  Future<UserEntity> getUserData(String userID) async {
    try {
      final res = await _remote.getUserData(userID);
      return res.toEntity();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<bool> saveUserData(UserEntity user) async {
    final res = await _remote.saveUserData(UserModel.fromEntity(user));
    if(res) {
      return true;
    }

    return false;
  }
}