import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:g_shop/constants/colors.dart';
import 'package:g_shop/constants/localization.dart';
import 'package:g_shop/constants/strings.dart';
import 'package:g_shop/core/exeptions/exception_handler.dart';
import 'package:g_shop/core/services/auth_service.dart';
import 'package:g_shop/core/services/dependency_injection.dart';
import 'package:g_shop/generated/locator.dart';
import 'package:g_shop/ui/utils/toast_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LogInViewModel extends BaseViewModel {

  final JsonDecoder _decoder = JsonDecoder();
  final loginFormKey = GlobalKey<FormState>();
  final AuthService _authService = diContainer.get();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void signInEmailPassword() async {
    try {
      await _authService.signInEmailPassword(emailController.text, passwordController.text);
      if (FirebaseAuth.instance.currentUser != null) {
        locator<NavigationService>().clearStackAndShow(routerAppLoadingView);
      }
    } catch (e) {
      showToast(textWrongData, redColor, whiteColor);
      handleErrorApp(e, _decoder);
    }
  }

  goToRegister() async {
    locator<NavigationService>().navigateTo(routerRegisterView);
    FocusManager.instance.primaryFocus.unfocus();
    emailController.clear();
    passwordController.clear();
  }
}
