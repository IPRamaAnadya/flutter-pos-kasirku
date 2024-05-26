import 'package:get_it/get_it.dart';
import 'package:pos/domain/usecases/store/usecase.dart';
import 'package:pos/domain/usecases/user/usecase.dart';

void domainInjection(GetIt locator) {
  locator.registerLazySingleton(() =>UserUsecase(locator()));
  locator.registerLazySingleton(() =>StoreUsecase(locator()));
}