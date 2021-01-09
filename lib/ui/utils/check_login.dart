import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:g_shop/core/base/custom_view_model_builder.dart';
import 'package:g_shop/core/models/user_model.dart';
import 'package:g_shop/core/services/user_service.dart';
import 'package:g_shop/ui/home_view/home_view.dart';
import 'package:g_shop/ui/login_view/login_view.dart';
import 'package:g_shop/ui/register_view/register_data_view.dart';
import 'package:g_shop/ui/utils/progress_screen.dart';
import 'package:stacked/stacked.dart';

class CheckLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilderConnect<CheckLoginViewModel>.reactive(
      viewModelBuilder: () => CheckLoginViewModel(),
      builder: (context, model, _) => model.isBusy
          ? ProgressScreen()
          : model.currentUser == null
              ? LogInView()
              : model.user == null
                  ? RegisterDataView()
                  : HomeView(),
    );
  }
}

class CheckLoginViewModel extends FutureViewModel {
  UserModel user;
  var currentUser;

  @override
  Future futureToRun() async {
    await init();
  }

  init() async {
    currentUser = FirebaseAuth.instance.currentUser;
    final uid = currentUser.uid;
    DocumentSnapshot res = await UserService().getUser(uid);
    user = UserModel(
      id: res.data()['id'],
      photo: res.data()['photo'],
      name: res.data()['name'],
      surname: res.data()['surname'],
      city: res.data()['city'],
      email: res.data()['email'],
      phoneNumber: res.data()['phoneNumber'],
      aboutYourself: res.data()['aboutYourself'],
    );
  }
}
