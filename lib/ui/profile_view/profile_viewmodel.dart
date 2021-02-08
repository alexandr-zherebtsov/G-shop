import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:g_shop/constants/strings.dart';
import 'package:g_shop/core/models/theme_model.dart';
import 'package:g_shop/core/models/user_model.dart';
import 'package:g_shop/core/services/auth_service.dart';
import 'package:g_shop/core/services/dependency_injection.dart';
import 'package:g_shop/core/services/user_service.dart';
import 'package:g_shop/generated/locator.dart';
import 'package:g_shop/generated/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileViewModel extends BaseViewModel {
  final AuthService _authService = diContainer.get();

  UserModel user;
  String currentUserUid = '';

  bool _num = true;
  bool get num => _num;

  set numCheck(bool num) {
    _num = num;
    notifyListeners();
  }

  numFun (String phoneNumber) {
    if (num) {
      launch('tel://$phoneNumber');
      numCheck = false;
      Future.delayed(const Duration(seconds: 2), () {
        numCheck = true;
      });
    }
  }

  initUser(String uid) async {
    setBusy(true);
    currentUserUid = FirebaseAuth.instance.currentUser.uid;
    DocumentSnapshot res = await UserService().getUser(uid);
    user = UserModel(
      id: res.data()[userModelId],
      photo: res.data()[userModelPhoto],
      name: res.data()[userModelName],
      surname: res.data()[userModelSurname],
      city: res.data()[userModelCity],
      email: res.data()[userModelEmail],
      phoneNumber: res.data()[userModelPhoneNumber],
      aboutYourself: res.data()[userModelAboutYourself],
    );
    setBusy(false);
  }

  void logOut() async {
    await _authService.logOut();
    notifyListeners();
    locator<NavigationService>().clearStackAndShow(routerAppLoadingView);
  }

  void toProfileEditing({
    String name,
    String surname,
    String city,
    String email,
    String phoneNumber,
    String aboutYourself,
  }) {
    locator<NavigationService>().navigateTo(
      routerProfileEditingView,
      arguments: ProfileEditingViewArguments(
        name: name,
        surname: surname,
        city: city,
        email: email,
        phoneNumber: phoneNumber,
        aboutYourself: aboutYourself,
      ),
    );
  }

  void toMyAdverts() {
    locator<NavigationService>().navigateTo(routerMyAdvertsView);
  }

  void back() {
    locator<NavigationService>().back();
  }

  List<ThemeModel> get themes => List<ThemeModel>.generate(
    2, (index) => ThemeModel(
      index: index,
      title: _getTitleForIndex(index)),
  );

  String _getTitleForIndex(int index) {
    switch (index) {
      case 0:
        return themeLight;
      case 1:
        return themeDark;
    }
    return themeNoTheme;
  }

}
