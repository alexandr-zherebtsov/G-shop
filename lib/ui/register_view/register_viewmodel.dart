import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:g_shop/constants/colors.dart';
import 'package:g_shop/constants/localization.dart';
import 'package:g_shop/constants/strings.dart';
import 'package:g_shop/core/exceptions/exception_handler.dart';
import 'package:g_shop/core/models/user_model.dart';
import 'package:g_shop/core/services/auth_service.dart';
import 'package:g_shop/core/services/dependency_injection.dart';
import 'package:g_shop/core/services/user_service.dart';
import 'package:g_shop/generated/locator.dart';
import 'package:g_shop/ui/utils/other_utils.dart';
import 'package:g_shop/ui/utils/toast_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RegisterViewModel extends BaseViewModel {
  final JsonDecoder _decoder = JsonDecoder();

  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> registerDataFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> deleteFormKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController deletePasswordController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  final AuthService _authService = diContainer.get();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FocusManager _focusManager = FocusManager.instance;

  String getEmail() {
    try {
      return _firebaseAuth.currentUser.email;
    } catch (e) {
      return '';
    }
  }

  void registerEmailPassword() async {
    try {
      await _authService.registerEmailPassword(emailController.text, passwordController.text);
      if (_firebaseAuth.currentUser != null) {
        getEmail();
        locator<NavigationService>().clearStackAndShow(routerRegisterDataView);
        _focusManager.primaryFocus.unfocus();
        emailController.clear();
        passwordController.clear();
      }
    } catch (e) {
      showToast(textWrongData, colorRed, colorWhite);
      handleErrorApp(e, _decoder);
    }
  }

  void registerDataEmailPassword() async {
    try {
      var userReg = UserModel(
        id: _firebaseAuth.currentUser.uid,
        photo: '',
        name: nameController.text,
        surname: surnameController.text,
        city: cityController.text,
        email: FirebaseAuth.instance.currentUser.email,
        phoneNumber: dropFormatMaskedPhone(phoneNumberController.text),
        aboutYourself: '',
      ).toFirebase();
      await UserService().createUser(userReg);
      locator<NavigationService>().clearStackAndShow(routerAppLoadingView);
      _focusManager.primaryFocus.unfocus();
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
    _focusManager.primaryFocus.unfocus();
    emailController.clear();
    passwordController.clear();
  }

  void deleteUser(String email) async {
    if (deleteFormKey.currentState.validate()) {
      try {
        bool authRes = await _authService.signInEmailPassword(email, deletePasswordController.text);
        if(authRes) {
          await _authService.deleteUser(deletePasswordController.text);
          await _authService.logOut();
          locator<NavigationService>().clearStackAndShow(routerAppLoadingView);
        } else {
          showToast(textIncorrectPassword, colorRed, colorWhite);
        }
      } catch(e) {
        showToast(textIncorrectPassword, colorRed, colorWhite);
      }
    }
  }
}
