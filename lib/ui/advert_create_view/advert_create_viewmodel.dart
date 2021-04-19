import 'dart:io';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:g_shop/constants/localization.dart';
import 'package:g_shop/constants/strings.dart';
import 'package:g_shop/core/models/advert_model.dart';
import 'package:g_shop/core/services/advert_service.dart';
import 'package:g_shop/generated/locator.dart';
import 'package:g_shop/generated/router.gr.dart';
import 'package:g_shop/ui/utils/other_utils.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:g_shop/core/exceptions/exception_handler.dart';

class AdvertCreateViewModel extends BaseViewModel {
  final TextEditingController headlineController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final JsonDecoder _decoder = JsonDecoder();
  final createAdvertDataFormKey = GlobalKey<FormState>();
  final FirebaseStorage _fs = FirebaseStorage.instance;
  List<Asset> images = <Asset>[];
  List<String> imagesUrls = <String>[];
  bool isValidate = true;
  bool isImg = true;

  void createAdvertData() async {
    setBusy(true);
    try {
      await uploadImage();
      AdvertModel createAdvert = AdvertModel(
        id: generateId('AD'),
        uid: FirebaseAuth.instance.currentUser.uid,
        headline: headlineController.text,
        price: int.parse(priceController.text),
        images: imagesUrls,
        description: descriptionController.text,
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
        saved: [],
      );
      await AdvertService().createAdvert(createAdvert);
      FocusManager.instance.primaryFocus.unfocus();
      headlineController.clear();
      priceController.clear();
      descriptionController.clear();
      await toHome();
    } catch (e) {
      handleErrorApp(e, _decoder);
    }
    setBusy(false);
  }

  Future<void> toHome() async{
    await locator<NavigationService>().clearStackAndShow(
      routerHomeView,
      arguments: HomeViewArguments(pageIndex: 0),
    );
  }

  Future<void> loadImages() async {
    List<Asset> resultList = [];
    String error = 'No Error Detected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: 'chat'),
        materialOptions: MaterialOptions(
          lightStatusBar: false,
          useDetailsView: false,
          allViewTitle: textAllPhotos,
          statusBarColor: colorStatusAP,
          actionBarColor: colorActionAP,
          actionBarTitle: textSelectPhotos,
          selectCircleStrokeColor: colorCircleAP,
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
      print(error);
    }
    images = resultList;
    notifyListeners();
  }

  void deleteChosenImg(Asset e) {
    images.removeWhere((img) => img == e);
    notifyListeners();
  }

  Future<void> uploadImage() async {
    for(int i = 0; i < images.length; i++) {
      UploadTask uploadTask = _fs.ref().child('adverts/${generateId('AI')}').putFile(
        File(await FlutterAbsolutePath.getAbsolutePath(images[i].identifier)),
      );
      imagesUrls.add(await(await uploadTask).ref.getDownloadURL());
    }
  }
}
