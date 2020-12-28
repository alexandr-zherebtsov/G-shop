// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../ui/advert_create_view/advert_create_view.dart';
import '../ui/advert_editing_view/advert_editing_view.dart';
import '../ui/advert_view/advert_view.dart';
import '../ui/home_view/home_view.dart';
import '../ui/login_view/login_view.dart';
import '../ui/my_advert_view/my_advert_view.dart';
import '../ui/my_profile_view/my_profile_view.dart';
import '../ui/profile_editing/profile_editing_view.dart';
import '../ui/profile_view/profile_view.dart';
import '../ui/register_view/register_data_view.dart';
import '../ui/register_view/register_view.dart';
import '../ui/utils/check_login.dart';

class Routes {
  static const String checkLogin = '/';
  static const String homeView = '/home';
  static const String logInView = '/login';
  static const String registerView = '/register';
  static const String registerDataView = '/register_data';
  static const String advertView = '/advert';
  static const String myAdvertView = '/my_advert';
  static const String advertCreateView = '/advert_create';
  static const String advertEditingView = '/advert_editing';
  static const String profileView = '/profile';
  static const String myProfileView = '/my_profile';
  static const String profileEditingView = '/profile_editing';
  static const all = <String>{
    checkLogin,
    homeView,
    logInView,
    registerView,
    registerDataView,
    advertView,
    myAdvertView,
    advertCreateView,
    advertEditingView,
    profileView,
    myProfileView,
    profileEditingView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.checkLogin, page: CheckLogin),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.logInView, page: LogInView),
    RouteDef(Routes.registerView, page: RegisterView),
    RouteDef(Routes.registerDataView, page: RegisterDataView),
    RouteDef(Routes.advertView, page: AdvertView),
    RouteDef(Routes.myAdvertView, page: MyAdvertView),
    RouteDef(Routes.advertCreateView, page: AdvertCreateView),
    RouteDef(Routes.advertEditingView, page: AdvertEditingView),
    RouteDef(Routes.profileView, page: ProfileView),
    RouteDef(Routes.myProfileView, page: MyProfileView),
    RouteDef(Routes.profileEditingView, page: ProfileEditingView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    CheckLogin: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => CheckLogin(),
        settings: data,
      );
    },
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeView(),
        settings: data,
      );
    },
    LogInView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LogInView(),
        settings: data,
      );
    },
    RegisterView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => RegisterView(),
        settings: data,
      );
    },
    RegisterDataView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => RegisterDataView(),
        settings: data,
      );
    },
    AdvertView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AdvertView(),
        settings: data,
      );
    },
    MyAdvertView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => MyAdvertView(),
        settings: data,
      );
    },
    AdvertCreateView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AdvertCreateView(),
        settings: data,
      );
    },
    AdvertEditingView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AdvertEditingView(),
        settings: data,
      );
    },
    ProfileView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ProfileView(),
        settings: data,
      );
    },
    MyProfileView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => MyProfileView(),
        settings: data,
      );
    },
    ProfileEditingView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ProfileEditingView(),
        settings: data,
      );
    },
  };
}
