import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:g_shop/constants/strings.dart';
import 'package:g_shop/core/models/advert_model.dart';
import 'package:g_shop/core/services/advert_service.dart';
import 'package:g_shop/generated/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:g_shop/core/exeptions/exception_handler.dart';

class AdvertCreateViewModel extends BaseViewModel {
  TextEditingController headlineController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final JsonDecoder _decoder = JsonDecoder();
  final createAdvertDataFormKey = GlobalKey<FormState>();

  void createAdvertData() async {
    try {
      var createAdvert = AdvertModel(
        uid: FirebaseAuth.instance.currentUser.uid,
        headline: headlineController.text,
        price: int.parse(priceController.text),
        images: [],
        description: descriptionController.text,
        created: DateTime.now().toString(),
      );
      await AdvertService().createAdvert(createAdvert);
      toHome();
      FocusManager.instance.primaryFocus.unfocus();
      headlineController.clear();
      priceController.clear();
      descriptionController.clear();
    } catch (e) {
      handleErrorApp(e, _decoder);
    }
  }

  void toHome() {
    locator<NavigationService>().clearStackAndShow(routerHomeView);
  }

  void back() {
    locator<NavigationService>().back();
  }
}
