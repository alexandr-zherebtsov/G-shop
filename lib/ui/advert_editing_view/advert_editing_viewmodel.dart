import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:g_shop/constants/strings.dart';
import 'package:g_shop/core/models/advert_model.dart';
import 'package:g_shop/core/services/advert_service.dart';
import 'package:g_shop/generated/locator.dart';
import 'package:g_shop/generated/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AdvertEditingViewModel extends BaseViewModel {
  final TextEditingController headlineController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Future<void> editAdvert(AdvertModel advert) async {
    Map<String, Object> advertEdited = AdvertModel(
      id: advert.id,
      uid: advert.uid,
      headline: headlineController.text,
      price: int.parse(priceController.text),
      description: descriptionController.text,
      images: advert.images,
      createdAt: advert.createdAt,
      updatedAt: Timestamp.now(),
      saved: advert.saved,
    ).toFirebase();
    await AdvertService().editAdvert(advert.id, advertEdited);
    toHome();
  }

  Future<void> deleteAdvert(String id) async {
    await AdvertService().deleteAdvert(id);
    toHome();
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
