import 'package:pos/domain/entities/entities.dart';

import '../../../models/models.dart';

abstract class UserRemoteDatasource {
  Future<UserModel> getUserData(String userID);
  Future<bool> saveUserData(UserModel user);
}