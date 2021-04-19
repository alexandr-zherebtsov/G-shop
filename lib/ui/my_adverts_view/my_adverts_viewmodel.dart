import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:g_shop/constants/strings.dart';
import 'package:g_shop/core/models/advert_model.dart';
import 'package:g_shop/core/services/advert_service.dart';
import 'package:g_shop/generated/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:g_shop/core/exceptions/exception_handler.dart';

class MyAdvertsViewModel extends FutureViewModel {
  final JsonDecoder _decoder = JsonDecoder();
  bool isSearch = false;
  final TextEditingController searchTextController = TextEditingController();
  final currentUserUid = FirebaseAuth.instance.currentUser.uid;
  List<AdvertModel> myAdverts = [];
  List<AdvertModel> mySearchedAdverts = [];

  @override
  Future futureToRun() async {
    await getMyAdverts();
    notifyListeners();
  }

  getMyAdverts() async {
    try {
      myAdverts = await locator<AdvertService>().getMyAdverts(currentUserUid);
    } catch (e) {
      handleErrorApp(e, _decoder);
    }
  }

  void activateSearch() {
    isSearch = true;
    notifyListeners();
  }

  onChangedSearch() {
    mySearchedAdverts.clear();
    for(int i = 0; i < myAdverts.length; i++) {
      if(myAdverts[i].headline.replaceAll(' ', '').trim().toLowerCase().contains(searchTextController.text.replaceAll(' ', '').trim().toLowerCase())
      || myAdverts[i].price.toString().replaceAll(' ', '').trim().toLowerCase().startsWith(searchTextController.text.replaceAll(' ', '').trim().toLowerCase())
      ) {
        mySearchedAdverts..add(myAdverts[i]);
      }
    }
    notifyListeners();
  }

  void clearSearch() {
    searchTextController.clear();
    isSearch = false;
    notifyListeners();
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
