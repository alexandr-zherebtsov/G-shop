import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:g_shop/core/exeptions/exception_handler.dart';
import 'package:g_shop/core/models/advert_model.dart';

class AdvertService {
  final JsonDecoder _decoder = JsonDecoder();
  FirebaseFirestore _db = FirebaseFirestore.instance;
  String _advertsName = 'adverts';

  Future<List<AdvertModel>> getAdverts() async {
    QuerySnapshot res = await _db.collection(_advertsName).orderBy('updatedAt').get();
    List<AdvertModel> advertsList = [];
    try {
      res.docs.forEach((e) {
        advertsList.add(AdvertModel(
          id: e.id,
          uid: e['uid'] ?? '',
          headline: e['headline'] ?? '',
          price: e['prise'] ?? '',
          description: e['description'] ?? '',
          images: e['images'] ?? [],
          createdAt: e['createdAt'],
          updatedAt: e['updatedAt'],
          saved: e['saved'] ?? [],
        ));
      });
    } catch(e) {
      handleErrorApp(e, _decoder);
    }
    return advertsList.reversed.toList();
  }

  Future<void> createAdvert(AdvertModel createAdvert) async {
    return await _db.collection(_advertsName).doc(createAdvert.id).set({
      'id': createAdvert.id,
      'uid': createAdvert.uid,
      'headline': createAdvert.headline,
      'prise': createAdvert.price,
      'description': createAdvert.description,
      'images': createAdvert.images,
      'createdAt': createAdvert.createdAt,
      'updatedAt': createAdvert.updatedAt,
      'saved': createAdvert.saved,
    }).catchError((e) {
      handleErrorApp(e, _decoder);
    });
  }

  Future<List<AdvertModel>> getMyAdverts(String uid) async {
    QuerySnapshot res = await _db.collection(_advertsName).where('uid', isEqualTo: uid).orderBy('updatedAt').get();
    List<AdvertModel> advertsList = [];
    res.docs.forEach((e) {
      advertsList.add(AdvertModel(
        id: e.id,
        uid: e['uid'] ?? '',
        headline: e['headline'] ?? '',
        price: e['prise'] ?? '',
        description: e['description'] ?? '',
        images: e['images'] ?? [],
        createdAt: e['createdAt'],
        updatedAt: e['updatedAt'],
        saved: e['saved'] ?? [],
      ));
    });
    return advertsList.reversed.toList();
  }

  Future<List<AdvertModel>> getMySavedAdverts(String uid) async {
    QuerySnapshot res = await _db.collection(_advertsName).where('saved', arrayContains: uid).orderBy('updatedAt').get();
    List<AdvertModel> advertsList = [];
    res.docs.forEach((e) {
      advertsList.add(AdvertModel(
        id: e.id,
        uid: e['uid'] ?? '',
        headline: e['headline'] ?? '',
        price: e['prise'] ?? '',
        description: e['description'] ?? '',
        images: e['images'] ?? [],
        createdAt: e['createdAt'],
        updatedAt: e['updatedAt'],
        saved: e['saved'] ?? [],
      ));
    });
    return advertsList.reversed.toList();
  }

  Future<void> editAdvert(String id, Map<String, dynamic> advert) async {
    try {
      await _db.collection(_advertsName).doc(id).update(advert);
    } catch (e) {
      handleErrorApp(e, _decoder);
    }
  }

  Future<void> toSavedAdvert(String id, Map<String, dynamic> advert) async {
    try {
      await _db.collection(_advertsName).doc(id).update(advert);
    } catch (e) {
      handleErrorApp(e, _decoder);
    }
  }

  Future<void> deleteAdvert(String id) async {
    try {
      await _db.collection(_advertsName).doc(id).delete();
    } catch (e) {
      handleErrorApp(e, _decoder);
    }
  }
}
