import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:g_shop/core/exeptions/exception_handler.dart';
import 'package:g_shop/core/models/advert_model.dart';
import 'package:g_shop/core/services/advert_service.dart';
import 'package:g_shop/generated/locator.dart';
import 'package:g_shop/generated/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends FutureViewModel {
  final JsonDecoder _decoder = JsonDecoder();
  String currentUserUid = '';
  List<AdvertModel> adverts;

  void toCheckLogin() {
    locator<NavigationService>().clearStackAndShow(
      '/check_login',
    );
  }

  @override
  Future futureToRun() async {
    await getAdverts();
  }

  Future<void> getAdverts() async {
    currentUserUid = FirebaseAuth.instance.currentUser.uid;
    try {
      adverts = await locator<AdvertService>().getAdverts();
    } catch (e) {
      handleErrorApp(e, _decoder);
    }
  }

  void toMyProfile() {
    locator<NavigationService>().navigateTo('/profile',
        arguments: ProfileViewArguments(uid: currentUserUid));
  }

  void toAdvertCreate() {
    locator<NavigationService>().navigateTo('/advert_create');
  }
}
