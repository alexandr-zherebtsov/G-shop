import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:g_shop/constants/colors.dart';
import 'package:g_shop/core/exeptions/exception_handler.dart';
import 'package:g_shop/core/servises/auth_servise.dart';
import 'package:g_shop/core/servises/dependency_injection.dart';
import 'package:g_shop/data/database.dart';
import 'package:g_shop/domain/user.dart';
import 'package:g_shop/generated/locator.dart';
import 'package:g_shop/ui/utils/toast_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RegisterViewModel extends BaseViewModel {

  final JsonDecoder _decoder = JsonDecoder();
  final GlobalKey registerFormKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  final AuthService _authService = diContainer.get();

  void registerEmailPassword() async {
    try {
      await _authService.registerEmailPassword(emailController.text, passwordController.text);
      if (FirebaseAuth.instance.currentUser != null) {
        locator<NavigationService>().clearStackAndShow('/register_data');
        FocusManager.instance.primaryFocus.unfocus();
        emailController.clear();
        passwordController.clear();
      }
    } catch (e) {
      showToast('Wrong data', redColor, whiteColor);
      handleErrorApp(e, _decoder);
    }
  }

  void registerDataEmailPassword() async {
    try {
      var userReg = UserModel(
        id: FirebaseAuth.instance.currentUser.uid,
        name: nameController.text,
        surname: surnameController.text,
        city: cityController.text,
        phoneNumber: phoneNumberController.text,
      ).toFirebase();
      await Database().createUser(userReg);
      locator<NavigationService>().clearStackAndShow('/');
      FocusManager.instance.primaryFocus.unfocus();
      nameController.clear();
      surnameController.clear();
      cityController.clear();
      phoneNumberController.clear();
    } catch (e) {
      handleErrorApp(e, _decoder);
    }
  }

  void back() {
    locator<NavigationService>().back();
    FocusManager.instance.primaryFocus.unfocus();
    emailController.clear();
    passwordController.clear();
  }
}
