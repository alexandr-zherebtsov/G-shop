import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Database {
  FirebaseFirestore db = FirebaseFirestore.instance;

  getUser() async {
    final user = FirebaseAuth.instance.currentUser;
    return await db.collection('users').doc('${user.uid}').get();
  }

  createUser(userReg) async {
    final userData = FirebaseAuth.instance.currentUser;
    return await db.collection('users').doc('${userData.uid}').set(userReg).then((value) => getUser());
  }
}