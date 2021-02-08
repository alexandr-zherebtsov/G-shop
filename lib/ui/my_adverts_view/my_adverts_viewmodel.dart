import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:g_shop/constants/strings.dart';
import 'package:g_shop/core/models/advert_model.dart';
import 'package:g_shop/core/services/advert_service.dart';
import 'package:g_shop/generated/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:g_shop/core/exeptions/exception_handler.dart';

class MyAdvertsViewModel extends FutureViewModel {
  final JsonDecoder _decoder = JsonDecoder();
  List<AdvertModel> myAdverts;

  @override
  Future futureToRun() async {
    await getMyAdverts();
  }

  getMyAdverts() async {
    try {
      final uid = FirebaseAuth.instance.currentUser.uid;
      myAdverts = await locator<AdvertService>().getMyAdverts(uid);
    } catch (e) {
      handleErrorApp(e, _decoder);
    }
  }

  void back() {
    locator<NavigationService>().back();
  }

  void advert() {
    locator<NavigationService>().navigateTo(routerAdvertView);
  }

  void advertCreate() {
    locator<NavigationService>().navigateTo(routerAdvertCreateView);
  }
}
