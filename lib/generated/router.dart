import 'package:auto_route/auto_route_annotations.dart';
import 'package:g_shop/ui/advert_create_view/advert_create_view.dart';
import 'package:g_shop/ui/advert_editing_view/advert_editing_view.dart';
import 'package:g_shop/ui/advert_view/advert_view.dart';
import 'package:g_shop/ui/home_view/home_view.dart';
import 'package:g_shop/ui/login_view/login_view.dart';
import 'package:g_shop/ui/my_advert_view/my_advert_view.dart';
import 'package:g_shop/ui/my_profile_view/my_profile_view.dart';
import 'package:g_shop/ui/profile_editing/profile_editing_view.dart';
import 'package:g_shop/ui/profile_view/profile_view.dart';
import 'package:g_shop/ui/register_view/register_data_view.dart';
import 'package:g_shop/ui/register_view/register_view.dart';
import 'package:g_shop/ui/utils/check_login.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: CheckLogin, initial: true, path: "/"),
    MaterialRoute(page: HomeView, path: "/home"),
    MaterialRoute(page: LogInView, path: "/login"),
    MaterialRoute(page: RegisterView, path: "/register"),
    MaterialRoute(page: RegisterDataView, path: "/register_data"),
    MaterialRoute(page: AdvertView, path: "/advert"),
    MaterialRoute(page: MyAdvertView, path: "/my_advert"),
    MaterialRoute(page: AdvertCreateView, path: "/advert_create"),
    MaterialRoute(page: AdvertEditingView, path: "/advert_editing"),
    MaterialRoute(page: ProfileView, path: "/profile"),
    MaterialRoute(page: MyProfileView, path: "/my_profile"),
    MaterialRoute(page: ProfileEditingView, path: "/profile_editing"),
  ],
)
class $Router {}