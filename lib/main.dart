import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos/presentations/features/authentication/login/page.dart';
import 'package:pos/presentations/features/authentication/login/provider.dart';
import 'package:pos/presentations/features/cart/provider.dart';
import 'package:pos/presentations/features/products/list.dart';
import 'package:pos/presentations/features/products/list.dart';
import 'package:pos/presentations/features/products/provider.dart';
import 'package:pos/presentations/features/stores/create_store/page.dart';
import 'package:pos/presentations/features/stores/create_store/provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'injection.dart' as di;
import 'firebase_options.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
var uuid = Uuid();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => di.locator<LoginProvider>()),
        ChangeNotifierProvider(create: (_) => di.locator<CreateStoreProvider>()),
        ChangeNotifierProvider(create: (_) => di.locator<ProductProvider>()),
        ChangeNotifierProvider(create: (_) => di.locator<CartProvider>()),
      ],
      child: MaterialApp(
        title: 'Kasirku',
        home: ProductListPage(),
        debugShowCheckedModeBanner: false,
        navigatorObservers: [routeObserver],
        navigatorKey: navigatorKey,
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case LoginPage.routeName:
              return CupertinoPageRoute(builder: (context) => LoginPage());
            case CreateStorePage.routeName:
              return CupertinoPageRoute(builder: (context) => CreateStorePage());
            case ProductListPage.routeName:
              return CupertinoPageRoute(builder: (context) => ProductListPage());
          }
        },
      ),
    );
  }
}
