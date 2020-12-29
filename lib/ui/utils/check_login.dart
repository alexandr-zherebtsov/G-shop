import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:g_shop/ui/home_view/home_view.dart';
import 'package:g_shop/ui/login_view/login_view.dart';
import 'package:g_shop/ui/utils/first_progress_screen.dart';

class CheckLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser == null
        ? FutureBuilder(
            future: Future.delayed(Duration(seconds: 1)),
            builder: (c, s) => s.connectionState == ConnectionState.done
                ? LogInView()
                : FirstProgressScreen())
        : FutureBuilder(
            future: Future.delayed(Duration(seconds: 1)),
            builder: (c, s) => s.connectionState == ConnectionState.done
                ? HomeView()
                : FirstProgressScreen());
  }
}
