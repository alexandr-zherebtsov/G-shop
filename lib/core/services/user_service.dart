import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:g_shop/core/exeptions/exception_handler.dart';
import 'package:g_shop/core/models/advert_model.dart';

class UserService {
  final JsonDecoder _decoder = JsonDecoder();
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<DocumentSnapshot> getUser(uid) async {
    return await _db
        .collection('users')
        .doc(uid)
        .get()
        .catchError((e) {
      handleErrorApp(e, _decoder);
    });
  }

  Future<DocumentSnapshot> createUser(userReg) async {
    final userData = FirebaseAuth.instance.currentUser;
    return await _db
        .collection('users')
        .doc('${userData.uid}')
        .set(userReg)
        .then((value) => getUser(userData.uid))
        .catchError((e) {
      handleErrorApp(e, _decoder);
    });
  }

  Future<void> createAdvert(AdvertModel createAdvert) async {
    return await _db.collection('adverts').add({
      'uid': createAdvert.uid,
      'headline': createAdvert.headline,
      'price': createAdvert.price,
      'description': createAdvert.description,
      'images': createAdvert.images,
    }).catchError((e) {
      handleErrorApp(e, _decoder);
    });
  }

}
