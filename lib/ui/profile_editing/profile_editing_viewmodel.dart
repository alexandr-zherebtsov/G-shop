import 'package:flutter/material.dart';
import 'package:g_shop/generated/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProfileEditingViewModel extends FutureViewModel {

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController aboutYourselfController = TextEditingController();

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