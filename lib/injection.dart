import 'package:get_it/get_it.dart';
import 'package:pos/data/data.dart';
import 'package:pos/domain/di/injection.dart';
import 'package:pos/presentations/di/injection.dart';

final locator = GetIt.instance;

void init() {
  dataInjection(locator);
  domainInjection(locator);
  presentationInjection(locator);
}