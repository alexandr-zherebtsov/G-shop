import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:g_shop/constants/colors.dart';
import 'package:g_shop/constants/strings.dart';
import 'package:g_shop/core/models/theme_model.dart';
import 'package:g_shop/core/models/user_model.dart';
import 'package:g_shop/core/services/auth_service.dart';
import 'package:g_shop/core/services/dependency_injection.dart';
import 'package:g_shop/core/services/user_service.dart';
import 'package:g_shop/generated/locator.dart';
import 'package:g_shop/generated/router.gr.dart';
import 'package:g_shop/ui/utils/other_utils.dart';
import 'package:g_shop/ui/widgets/avatar_bottom_sheet.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileViewModel extends BaseViewModel {
  final AuthService _authService = diContainer.get();
  final UserService _userService = UserService();
  final FirebaseAuth _fb = FirebaseAuth.instance;
  final FirebaseStorage _fs = FirebaseStorage.instance;
  final ImagePicker image = ImagePicker();

  UserModel user;
  String currentUserUid = '';

  bool _num = true;
  bool get num => _num;

  set numCheck(bool num) {
    _num = num;
    notifyListeners();
  }

  numFun (String phoneNumber) {
    if (num) {
      launch('tel://$phoneNumber');
      numCheck = false;
      Future.delayed(const Duration(seconds: 2), () {
        numCheck = true;
      });
    }
  }

  initUser(String uid) async {
    setBusy(true);
    currentUserUid = _fb.currentUser.uid;
    DocumentSnapshot res = await UserService().getUser(uid);
    user = UserModel(
      id: res.data()[userModelId],
      photo: res.data()[userModelPhoto],
      name: res.data()[userModelName],
      surname: res.data()[userModelSurname],
      city: res.data()[userModelCity],
      email: res.data()[userModelEmail],
      phoneNumber: res.data()[userModelPhoneNumber],
      aboutYourself: res.data()[userModelAboutYourself],
    );
    setBusy(false);
  }

  void logOut() async {
    await _authService.logOut();
    notifyListeners();
    locator<NavigationService>().clearStackAndShow(routerAppLoadingView);
  }

  void toProfileEditing({UserModel user}) {
    locator<NavigationService>().navigateTo(
      routerProfileEditingView,
      arguments: ProfileEditingViewArguments(user: user),
    );
  }

  void toMyAdverts() {
    locator<NavigationService>().navigateTo(routerMyAdvertsView);
  }

  void buildBottomSheet(BuildContext context, UserModel user) {
    showModalBottomSheet(
      elevation: 8.0,
      context: context,
      isScrollControlled: true,
      clipBehavior: Clip.hardEdge,
      barrierColor: colorTransparent,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (context) => avatarBottomSheet(
        context,
        user.photo,
        () => changeAvatar(user),
        () => deleteAvatar(user),
      ),
    );
  }

  Future<void> changeAvatar(UserModel user) async {
    try {
      goBackNav();
      PickedFile pickedFile = await image.getImage(source: ImageSource.gallery);
      setBusy(true);
      String photoUrl = await uploadUserImage(File(pickedFile.path), user);
      await addPhotoToUser(user, photoUrl);
    } catch(e) {
      print(e);
    }
    setBusy(false);
  }

  Future<String> uploadUserImage(File pickedFile, UserModel user) async {
    if (user.photo.isNotEmpty) {
      try {
        await deleteAvatar(user, isOnlyDelete: false);
      } catch(e) {
        print(e);
      }
    }
    UploadTask uploadTask = _fs.ref().child('users/${generateId('UI')}').putFile(pickedFile);
    String imgUrls = await(await uploadTask).ref.getDownloadURL();
    return imgUrls;
  }

  Future<void> addPhotoToUser(UserModel user, String photoUrl) async {
    try {
      user.photo = photoUrl;
      await _userService.addUserPhoto(user.id, user.toFirebase());
      initUser(_fb.currentUser.uid);
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteAvatar(UserModel user, {isOnlyDelete = true}) async {
    if(isOnlyDelete) {
      goBackNav();
      setBusy(true);
    }
    Reference photoRef = _fs.refFromURL(user.photo);
    await photoRef.delete();
    if(isOnlyDelete) {
      await addPhotoToUser(user, '');
      initUser(_fb.currentUser.uid);
      setBusy(false);
    }
  }

  List<ThemeModel> get themes => List<ThemeModel>.generate(
    2, (index) => ThemeModel(
      index: index,
      title: _getTitleForIndex(index)),
  );

  String _getTitleForIndex(int index) {
    switch (index) {
      case 0:
        return themeLight;
      case 1:
        return themeDark;
    }
    return themeNoTheme;
  }

}
