import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:g_shop/constants/strings.dart';
import 'package:g_shop/core/exeptions/exception_handler.dart';
import 'package:g_shop/core/models/advert_model.dart';
import 'package:g_shop/core/services/advert_service.dart';
import 'package:g_shop/generated/locator.dart';
import 'package:g_shop/generated/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AllAdvertsViewModel extends FutureViewModel {
  final JsonDecoder _decoder = JsonDecoder();
  bool isSearch = false;
  final TextEditingController searchTextController = TextEditingController();
  String currentUserUid = '';
  List<AdvertModel> adverts = [];
  List<AdvertModel> advertsSearched = [];

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

  void activateSearch() {
    isSearch = true;
    notifyListeners();
  }

  onChangedSearch() {
    advertsSearched.clear();
    for(int i = 0; i < adverts.length; i++) {
      if(adverts[i].headline.replaceAll(' ', '').trim().toLowerCase().contains(searchTextController.text.replaceAll(' ', '').trim().toLowerCase())
          || adverts[i].price.toString().replaceAll(' ', '').trim().toLowerCase().startsWith(searchTextController.text.replaceAll(' ', '').trim().toLowerCase())
      ) {
        advertsSearched..add(adverts[i]);
      }
    }
    notifyListeners();
  }

  void clearSearch() {
    searchTextController.clear();
    advertsSearched.clear();
    isSearch = false;
    notifyListeners();
  }

  void toMyProfile() {
    locator<NavigationService>().navigateTo(routerProfileView, arguments: ProfileViewArguments(uid: currentUserUid));
  }

  void toAdvertCreate() {
    locator<NavigationService>().navigateTo(routerAdvertCreateView);
  }

}
