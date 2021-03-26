import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:g_shop/constants/strings.dart';
import 'package:g_shop/core/models/advert_model.dart';
import 'package:g_shop/core/services/advert_service.dart';
import 'package:g_shop/generated/locator.dart';
import 'package:g_shop/generated/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:g_shop/core/exeptions/exception_handler.dart';

class AdvertCreateViewModel extends BaseViewModel {
  final TextEditingController headlineController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final JsonDecoder _decoder = JsonDecoder();
  final createAdvertDataFormKey = GlobalKey<FormState>();

  void createAdvertData() async {
    try {
      AdvertModel createAdvert = AdvertModel(
        id: generateId(),
        uid: FirebaseAuth.instance.currentUser.uid,
        headline: headlineController.text,
        price: int.parse(priceController.text),
        images: [],
        description: descriptionController.text,
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
        saved: [],
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

  String generateId() {
    return DateTime.now().toString().replaceAll(' ', '').replaceAll('+', '')
        .replaceAll('-', '').replaceAll(':', '').replaceAll(',', '').replaceAll('.', '')
        + (100000000 + Random().nextInt(100000000)).toString();
  }

  void toHome() {
    locator<NavigationService>().clearStackAndShow(
      routerHomeView,
      arguments: HomeViewArguments(pageIndex: 0),
    );
  }

  void back() {
    locator<NavigationService>().back();
  }
}
