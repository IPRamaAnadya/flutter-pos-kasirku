import 'package:get_it/get_it.dart';
import 'package:pos/presentations/features/authentication/login/provider.dart';
import 'package:pos/presentations/features/cart/provider.dart';
import 'package:pos/presentations/features/products/list/provider.dart';
import 'package:pos/presentations/features/stores/create_store/provider.dart';

void presentationInjection(GetIt locator) {
    locator.registerFactory(() => LoginProvider(locator()));
    locator.registerFactory(() => CreateStoreProvider(locator()));
    locator.registerFactory(() => ProductProvider(locator()));
    locator.registerFactory(() => CartProvider());
}