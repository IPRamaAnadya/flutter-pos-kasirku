import 'package:pos/data/repositories/user/repository.dart';

import '../../entities/user.dart';

class UserUsecase {
  final UserRepository _repository;
  UserUsecase(this._repository);

  Future<UserEntity> getUser(String userID) => _repository.getUserData(userID);
  Future<bool> saveUser(UserEntity user) => _repository.saveUserData(user);
}