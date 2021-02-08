import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:g_shop/constants/strings.dart';
import 'package:g_shop/core/exeptions/exception_handler.dart';
import 'package:g_shop/core/models/user_model.dart';
import 'package:g_shop/core/services/user_service.dart';
import 'package:g_shop/generated/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AppLoadingViewModel extends BaseViewModel {
  final JsonDecoder _decoder = JsonDecoder();
  UserModel user;
  var currentUser;

  init() async {
    await initUser();
    await Future.delayed(Duration(milliseconds: 2000));
    if (currentUser == null) {
      toLogin();
    } else if (user == null) {
      toRegisterData();
    } else {
      toHome();
    }
  }

  initUser() async {
    try {
      currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final uid = currentUser.uid;
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
      }
    } catch (e) {
      handleErrorApp(e, _decoder);
    }
  }

  void toLogin() {
    locator<NavigationService>().clearStackAndShow(routerLogInView);
  }

  void toRegisterData() {
    locator<NavigationService>().clearStackAndShow(routerRegisterDataView);
  }

  void toHome() {
    locator<NavigationService>().clearStackAndShow(routerHomeView);
  }
}