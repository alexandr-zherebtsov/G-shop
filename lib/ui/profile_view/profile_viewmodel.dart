import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:g_shop/core/models/theme_model.dart';
import 'package:g_shop/core/models/user_model.dart';
import 'package:g_shop/core/services/auth_service.dart';
import 'package:g_shop/core/services/dependency_injection.dart';
import 'package:g_shop/core/services/user_service.dart';
import 'package:g_shop/generated/locator.dart';
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
      id: res.data()['id'],
      photo: res.data()['photo'],
      name: res.data()['name'],
      surname: res.data()['surname'],
      city: res.data()['city'],
      email: res.data()['email'],
      phoneNumber: res.data()['phoneNumber'],
      aboutYourself: res.data()['aboutYourself'],
    );
    setBusy(false);
  }

  void logOut() async {
    await _authService.logOut();
    notifyListeners();
    locator<NavigationService>().clearStackAndShow('/');
  }

  void toProfileEditing() {
    locator<NavigationService>().navigateTo('/profile_editing');
  }

  void toMyAdverts() {
    locator<NavigationService>().navigateTo('/my_adverts');
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
        return 'Light';
      case 1:
        return 'Dark';
    }
    return 'No theme for index';
  }

}
