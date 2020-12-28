import 'package:g_shop/core/servises/auth_servise.dart';
import 'package:g_shop/generated/locator.dart';
import 'package:get_it/get_it.dart';

GetIt diContainer = GetIt.instance;

class InjectorDI {
  static final InjectorDI singleton = InjectorDI._internal();
  Flavor flavor;

  InjectorDI._internal();

  Future<void> configure(Flavor flavor) async {
    assert(flavor != null);
    this.flavor = flavor;
    diContainer.registerLazySingleton<AuthService>(() => AuthService());
  }

  factory InjectorDI() {
    return singleton;
  }
}