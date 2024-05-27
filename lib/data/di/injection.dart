import 'package:get_it/get_it.dart';
import 'package:pos/data/datasources/datasources.dart';
import 'package:pos/data/datasources/local/stores/datasource.dart';
import 'package:pos/data/datasources/local/stores/prefs_datasource.dart';
import 'package:pos/data/datasources/remote/product/datasource.dart';
import 'package:pos/data/datasources/remote/product/firebase_datasource.dart';
import 'package:pos/data/repositories/product/repository.dart';
import 'package:pos/data/repositories/user/repository.dart';

import '../repositories/store/repository.dart';

dataInjection(GetIt locator) {
  locator.registerLazySingleton<UserRemoteDatasource>(()=> UserFBRemoteDatasource());
  locator.registerLazySingleton<UserRepository>(()=> UserRepositoryImpl(locator()));

  locator.registerLazySingleton<StoreRemoteDatasource>(()=> StoreFBRemoteDatasourceImpl());
  locator.registerLazySingleton<StoreLocalDatasource>(()=> StorePrefsDatasource());
  locator.registerLazySingleton<StoreRepository>(()=> StoreRepositoryImpl(locator(), locator()));

  locator.registerLazySingleton<ProductRemoteDatasource>(()=> ProductFBDatasource());
  locator.registerLazySingleton<ProductRepository>(()=> ProductRepositoryImpl(locator(), locator()));


}