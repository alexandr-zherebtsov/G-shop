import 'package:g_shop/generated/locator.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final locator = GetIt.instance;

enum Flavor { MOCK, DEV, PROD }

@injectableInit
void setupLocator() async {
  $initGetIt(locator);
}