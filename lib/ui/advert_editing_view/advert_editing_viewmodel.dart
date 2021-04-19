import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:g_shop/constants/strings.dart';
import 'package:g_shop/core/models/advert_model.dart';
import 'package:g_shop/core/services/advert_service.dart';
import 'package:g_shop/generated/locator.dart';
import 'package:g_shop/generated/router.gr.dart';
import 'package:g_shop/ui/utils/other_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AdvertEditingViewModel extends BaseViewModel {
  final TextEditingController headlineController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final FirebaseStorage _fs = FirebaseStorage.instance;
  final AdvertService _advertService = AdvertService();
  final ImagePicker image = ImagePicker();
  bool editImages = false;
  List<dynamic> imagesToEdit = [];
  List<dynamic> deletedImages = [];
  List<PickedFile> addedImages = [];

  Future<void> editAdvert(AdvertModel advert) async {
    setBusy(true);

    if (addedImages.isNotEmpty) {
      try {
        for (int i = 0; i < addedImages.length; i++) {
          UploadTask uploadTask = _fs.ref().child('adverts/${generateId('AI')}').putFile(
            File(await FlutterAbsolutePath.getAbsolutePath(addedImages[i].path)),
          );
          advert.images.add(await(await uploadTask).ref.getDownloadURL());
        }
      } catch(e) {
        print(e);
      }
    }

    if (deletedImages.isNotEmpty) {
      try {
        for (int i = 0; i < deletedImages.length; i++) {
          Reference photoRef = _fs.refFromURL(deletedImages[i]);
          await photoRef.delete();
          advert.images.removeWhere((e) => e == deletedImages[i]);
        }
      } catch(e) {
        print(e);
      }
    }

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

    await _advertService.editAdvert(advert.id, advertEdited);
    await toHome();

    setBusy(false);
  }

  Future<void> deleteAdvert(AdvertModel advert) async {
    setBusy(true);
    back();
    try {
      if (advert.images.isNotEmpty) {
        for (int i = 0; i < advert.images.length; i++) {
          Reference photoRef = _fs.refFromURL(advert.images[i]);
          await photoRef.delete();
        }
      }
    } catch(e) {
      print(e);
    }
    await _advertService.deleteAdvert(advert.id);
    await toHome();
    setBusy(false);
  }

  void cancelEditImages() {
    imagesToEdit.clear();
    deletedImages.clear();
    addedImages.clear();
  }

  void activateEditImages(List<dynamic> images) {
    imagesToEdit.clear();
    addedImages.clear();
    imagesToEdit.addAll(images);
    editImages = !editImages;
    notifyListeners();
  }

  Future<void> addImageToEdit() async {
    PickedFile pickedFile = await image.getImage(source: ImageSource.gallery);
    addedImages..add(pickedFile);
    notifyListeners();
  }

  void deleteImageToEdit(String img) {
    deletedImages..add(img);
    imagesToEdit..removeWhere((e) => e == img);
    notifyListeners();
  }

  void deleteImageFileToEdit(PickedFile img) {
    addedImages.removeWhere((e) => e == img);
    notifyListeners();
  }

  Future<void> toHome() async {
    await locator<NavigationService>().clearStackAndShow(
      routerHomeView,
      arguments: HomeViewArguments(pageIndex: 0),
    );
  }

  void back() {
    locator<NavigationService>().back();
  }
}
