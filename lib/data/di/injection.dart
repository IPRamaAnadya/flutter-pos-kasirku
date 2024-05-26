import 'package:get_it/get_it.dart';
import 'package:pos/data/datasources/datasources.dart';
import 'package:pos/data/repositories/user/repository.dart';

import '../repositories/store/repository.dart';

dataInjection(GetIt locator) {
  locator.registerLazySingleton<UserRemoteDatasource>(()=> UserFBRemoteDatasource());
  locator.registerLazySingleton<UserRepository>(()=> UserRepositoryImpl(locator()));
  locator.registerLazySingleton<StoreRemoteDatasource>(()=> StoreFBRemoteDatasourceImpl());
  locator.registerLazySingleton<StoreRepository>(()=> StoreRepositoryImpl(locator()));


}