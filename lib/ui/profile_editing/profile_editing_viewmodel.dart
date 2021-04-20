import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:g_shop/constants/colors.dart';
import 'package:g_shop/constants/localization.dart';
import 'package:g_shop/constants/strings.dart';
import 'package:g_shop/core/models/advert_model.dart';
import 'package:g_shop/core/models/user_model.dart';
import 'package:g_shop/core/services/advert_service.dart';
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
  final UserService _userService = UserService();
  final AuthService _authService = diContainer.get();
  final FirebaseStorage _fs = FirebaseStorage.instance;
  final AdvertService _advertService = locator<AdvertService>();
  final NavigationService _navigationService = locator<NavigationService>();

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
    _navigationService.clearStackAndShow(
      routerHomeView,
      arguments: HomeViewArguments(pageIndex: 3),
    );
  }

  void deleteUser(UserModel user) async {
    if (deleteFormKey.currentState.validate()) {
      try {
        bool authRes = await _authService.signInEmailPassword(user.email, deletePasswordController.text);
        if(authRes) {
          setBusy(true);
          back();

          List<AdvertModel> userAdverts = [];
          List<AdvertModel> savedAdverts = [];
          userAdverts = await _advertService.getMyAdverts(user.id);
          savedAdverts = await _advertService.getMySavedAdverts(user.id);

          if (userAdverts.length > 0) {
            for(int i = 0; i < userAdverts.length; i++) {
              if (userAdverts[i].images.isNotEmpty) {
                for (int j = 0; j < userAdverts[i].images.length; j++) {
                  Reference photoRef = _fs.refFromURL(userAdverts[i].images[j]);
                  await photoRef.delete();
                }
              }
              await _advertService.deleteAdvert(userAdverts[i].id);
            }
          }

          if (savedAdverts.length > 0) {
            for (int i = 0; i < savedAdverts.length; i++) {
              savedAdverts[i].saved.removeWhere((e) => e == user.id);
              Map<String, Object> advertEdited = AdvertModel(
                id: savedAdverts[i].id,
                uid: savedAdverts[i].uid,
                headline: savedAdverts[i].headline,
                price: savedAdverts[i].price,
                description: savedAdverts[i].description,
                images: savedAdverts[i].images,
                createdAt: savedAdverts[i].createdAt,
                updatedAt: savedAdverts[i].updatedAt,
                saved: savedAdverts[i].saved,
              ).toFirebase();
              await _advertService.editAdvert(savedAdverts[i].id, advertEdited);
            }
          }

          if(user.photo.isNotEmpty) {
            Reference userPhotoRef = _fs.refFromURL(user.photo);
            await userPhotoRef.delete();
          }

          await _userService.deleteUserFromCollection(user.id);
          await _authService.deleteUser(deletePasswordController.text);
          await _authService.logOut();
          _navigationService.clearStackAndShow(routerAppLoadingView);
          userAdverts.clear();
          savedAdverts.clear();
        } else {
          showToast(textIncorrectPassword, colorRed, colorWhite);
        }
      } catch(e) {
        showToast(textIncorrectPassword, colorRed, colorWhite);
      }
      setBusy(false);
    }
  }

  void back() {
    _navigationService.back();
  }
}
