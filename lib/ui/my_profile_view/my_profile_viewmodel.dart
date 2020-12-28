import 'package:firebase_auth/firebase_auth.dart';
import 'package:g_shop/core/models/theme_model.dart';
import 'package:g_shop/core/servises/auth_servise.dart';
import 'package:g_shop/core/servises/dependency_injection.dart';
import 'package:g_shop/generated/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MyProfileViewModel extends FutureViewModel {

  final AuthService _authService = diContainer.get();

  @override
  Future futureToRun() async {
    await init();
  }

  init() async {

  }

  void logOut() async {
    await _authService.logOut();
    notifyListeners();
    locator<NavigationService>().clearStackAndShow('/');
  }

  List<ThemeModel> get themes => List<ThemeModel>.generate(
      2, (index) => ThemeModel(
        index: index,
        title: _getTitleForIndex(index),
      ));

  String _getTitleForIndex(int index) {
    switch (index) {
      case 0:
        return 'Light';
      case 1:
        return 'Dark';
    }

    return 'No theme for index';
  }

  void back() {
    locator<NavigationService>().back();
  }

  void profileEditing() {
    locator<NavigationService>().navigateTo('/profile_editing');
  }

  void myAdvert() {
    locator<NavigationService>().navigateTo('/my_advert');
  }
}