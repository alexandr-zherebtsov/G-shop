import 'package:flutter/material.dart';
import 'package:g_shop/constants/colors.dart';
import 'package:g_shop/constants/localization.dart';
import 'package:g_shop/constants/strings.dart';
import 'package:g_shop/core/models/user_model.dart';
import 'package:g_shop/core/services/auth_service.dart';
import 'package:g_shop/core/services/dependency_injection.dart';
import 'package:g_shop/core/services/user_service.dart';
import 'package:g_shop/generated/locator.dart';
import 'package:g_shop/generated/router.gr.dart';
import 'package:g_shop/ui/utils/other_utils.dart';
import 'package:g_shop/ui/utils/toast_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProfileEditingViewModel extends BaseViewModel {
  UserService _userService = UserService();
  final AuthService _authService = diContainer.get();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController aboutYourselfController = TextEditingController();
  final TextEditingController deletePasswordController = TextEditingController();
  final GlobalKey<FormState> deleteFormKey = GlobalKey<FormState>();

  Future<void> editUser(UserModel user) async {
    Map<String, Object> userEdited = UserModel(
      id: user.id,
      photo: user.photo,
      name: nameController.text,
      surname: surnameController.text,
      city: cityController.text,
      email: user.email,
      phoneNumber: dropFormatMaskedPhone(phoneNumberController.text),
      aboutYourself: aboutYourselfController.text,
    ).toFirebase();
    await _userService.editUser(user.id, userEdited);
    toHome();
  }

  void toHome() {
    locator<NavigationService>().clearStackAndShow(
      routerHomeView,
      arguments: HomeViewArguments(pageIndex: 3),
    );
  }

  void deleteUser(String id, String email) async {
    if (deleteFormKey.currentState.validate()) {
      try {
        bool authRes = await _authService.signInEmailPassword(email, deletePasswordController.text);
        if(authRes) {
          await _userService.deleteUserFromCollection(id);
          await _authService.deleteUser(deletePasswordController.text);
          await _authService.logOut();
          locator<NavigationService>().clearStackAndShow(routerAppLoadingView);
        } else {
          showToast(textIncorrectPassword, redColor, whiteColor);
        }
      } catch(e) {
        showToast(textIncorrectPassword, redColor, whiteColor);
      }
    }
  }

  void back() {
    locator<NavigationService>().back();
  }
}
