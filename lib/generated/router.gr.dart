// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../core/models/advert_model.dart';
import '../ui/advert_create_view/advert_create_view.dart';
import '../ui/advert_editing_view/advert_editing_view.dart';
import '../ui/advert_view/advert_view.dart';
import '../ui/app_loading_view/app_loading_view.dart';
import '../ui/home_view/home_view.dart';
import '../ui/login_view/login_view.dart';
import '../ui/my_adverts_view/my_adverts_view.dart';
import '../ui/profile_editing/profile_editing_view.dart';
import '../ui/profile_view/profile_view.dart';
import '../ui/register_view/register_data_view.dart';
import '../ui/register_view/register_view.dart';

class Routes {
  static const String appLoadingView = '/';
  static const String homeView = '/home';
  static const String logInView = '/login';
  static const String registerView = '/register';
  static const String registerDataView = '/register_data';
  static const String advertView = '/advert';
  static const String myAdvertsView = '/my_adverts';
  static const String advertCreateView = '/advert_create';
  static const String advertEditingView = '/advert_editing';
  static const String profileView = '/profile';
  static const String profileEditingView = '/profile_editing';
  static const all = <String>{
    appLoadingView,
    homeView,
    logInView,
    registerView,
    registerDataView,
    advertView,
    myAdvertsView,
    advertCreateView,
    advertEditingView,
    profileView,
    profileEditingView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.appLoadingView, page: AppLoadingView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.logInView, page: LogInView),
    RouteDef(Routes.registerView, page: RegisterView),
    RouteDef(Routes.registerDataView, page: RegisterDataView),
    RouteDef(Routes.advertView, page: AdvertView),
    RouteDef(Routes.myAdvertsView, page: MyAdvertsView),
    RouteDef(Routes.advertCreateView, page: AdvertCreateView),
    RouteDef(Routes.advertEditingView, page: AdvertEditingView),
    RouteDef(Routes.profileView, page: ProfileView),
    RouteDef(Routes.profileEditingView, page: ProfileEditingView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    AppLoadingView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AppLoadingView(),
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
      final args = data.getArgs<AdvertViewArguments>(
        orElse: () => AdvertViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => AdvertView(
          key: args.key,
          e: args.e,
        ),
        settings: data,
      );
    },
    MyAdvertsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => MyAdvertsView(),
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
      final args = data.getArgs<AdvertEditingViewArguments>(
        orElse: () => AdvertEditingViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => AdvertEditingView(
          key: args.key,
          headline: args.headline,
          price: args.price,
          description: args.description,
        ),
        settings: data,
      );
    },
    ProfileView: (data) {
      final args = data.getArgs<ProfileViewArguments>(
        orElse: () => ProfileViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => ProfileView(
          key: args.key,
          uid: args.uid,
        ),
        settings: data,
      );
    },
    ProfileEditingView: (data) {
      final args = data.getArgs<ProfileEditingViewArguments>(
        orElse: () => ProfileEditingViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => ProfileEditingView(
          key: args.key,
          name: args.name,
          surname: args.surname,
          role: args.role,
          city: args.city,
          email: args.email,
          phoneNumber: args.phoneNumber,
          aboutYourself: args.aboutYourself,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// AdvertView arguments holder class
class AdvertViewArguments {
  final Key key;
  final AdvertModel e;
  AdvertViewArguments({this.key, this.e});
}

/// AdvertEditingView arguments holder class
class AdvertEditingViewArguments {
  final Key key;
  final String headline;
  final int price;
  final String description;
  AdvertEditingViewArguments(
      {this.key, this.headline, this.price, this.description});
}

/// ProfileView arguments holder class
class ProfileViewArguments {
  final Key key;
  final String uid;
  ProfileViewArguments({this.key, this.uid});
}

/// ProfileEditingView arguments holder class
class ProfileEditingViewArguments {
  final Key key;
  final String name;
  final String surname;
  final String role;
  final String city;
  final String email;
  final String phoneNumber;
  final String aboutYourself;
  ProfileEditingViewArguments(
      {this.key,
      this.name,
      this.surname,
      this.role,
      this.city,
      this.email,
      this.phoneNumber,
      this.aboutYourself});
}
