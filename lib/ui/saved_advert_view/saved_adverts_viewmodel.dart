import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:g_shop/constants/strings.dart';
import 'package:g_shop/core/exeptions/exception_handler.dart';
import 'package:g_shop/core/models/advert_model.dart';
import 'package:g_shop/core/services/advert_service.dart';
import 'package:g_shop/generated/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SavedAdvertsViewModel extends FutureViewModel {
  final JsonDecoder _decoder = JsonDecoder();
  bool isSearch = false;
  final TextEditingController searchTextController = TextEditingController();
  String currentUserUid = FirebaseAuth.instance.currentUser.uid;
  List<AdvertModel> advertsSaved = [];
  List<AdvertModel> advertsSavedSearched = [];

  @override
  Future futureToRun() async {
    await getAdverts();
  }

  Future<void> getAdverts() async {
    try {
      advertsSaved = await locator<AdvertService>().getMySavedAdverts(currentUserUid);
    } catch (e) {
      handleErrorApp(e, _decoder);
    }
  }

  void activateSearch() {
    isSearch = true;
    notifyListeners();
  }

  onChangedSearch() {
    advertsSavedSearched.clear();
    for(int i = 0; i < advertsSaved.length; i++) {
      if(advertsSaved[i].headline.replaceAll(' ', '').trim().toLowerCase().contains(searchTextController.text.replaceAll(' ', '').trim().toLowerCase())
          || advertsSaved[i].price.toString().replaceAll(' ', '').trim().toLowerCase().startsWith(searchTextController.text.replaceAll(' ', '').trim().toLowerCase())
      ) {
        advertsSavedSearched..add(advertsSaved[i]);
      }
    }
    notifyListeners();
  }

  void clearSearch() {
    searchTextController.clear();
    advertsSavedSearched.clear();
    isSearch = false;
    notifyListeners();
  }

  void toAdvertCreate() {
    locator<NavigationService>().navigateTo(routerAdvertCreateView);
  }

}
