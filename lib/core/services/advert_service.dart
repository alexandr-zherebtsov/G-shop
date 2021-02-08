import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:g_shop/core/exeptions/exception_handler.dart';
import 'package:g_shop/core/models/advert_model.dart';

class AdvertService {
  final JsonDecoder _decoder = JsonDecoder();
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<AdvertModel>> getAdverts() async {
    QuerySnapshot res = await db.collection('adverts').orderBy('created').get();
    List<AdvertModel> advertsList = [];
    res.docs.forEach((e) {
      advertsList.add(AdvertModel(
        id: e.id,
        uid: e['uid'],
        headline: e['headline'],
        price: e['prise'],
        description: e['description'],
        images: e['images'],
        created: e['created'],
      ));
    });
    return advertsList.reversed.toList();
  }

  Future<void> createAdvert(AdvertModel createAdvert) async {
    return await db.collection('adverts').add({
      'uid': createAdvert.uid,
      'headline': createAdvert.headline,
      'prise': createAdvert.price,
      'description': createAdvert.description,
      'images': createAdvert.images,
      'created': createAdvert.created,
    }).catchError((e) {
      handleErrorApp(e, _decoder);
    });
  }

  Future<List<AdvertModel>> getMyAdverts(String uid) async {
    QuerySnapshot res = await db.collection('adverts').orderBy('created').get();
    List<AdvertModel> advertsList = [];
    res.docs.forEach((e) {
      if (e.data()['uid'] == uid) {
        advertsList.add(AdvertModel(
          id: e.id,
          uid: e['uid'],
          headline: e['headline'],
          price: e['prise'],
          description: e['description'],
          images: e['images'],
          created: e['created'],
        ));
      }
    });
    return advertsList.reversed.toList();
  }
}
