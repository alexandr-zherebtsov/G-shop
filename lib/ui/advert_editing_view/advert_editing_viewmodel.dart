import 'package:flutter/material.dart';
import 'package:g_shop/generated/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AdvertEditingViewModel extends FutureViewModel {

  TextEditingController headlineController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Future futureToRun() async {
    await init();
  }

  init() async {

  }

  void back() {
    locator<NavigationService>().back();
  }
}