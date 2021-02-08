import 'package:auto_route/auto_route_annotations.dart';
import 'package:g_shop/constants/strings.dart';
import 'package:g_shop/ui/advert_create_view/advert_create_view.dart';
import 'package:g_shop/ui/advert_editing_view/advert_editing_view.dart';
import 'package:g_shop/ui/advert_view/advert_view.dart';
import 'package:g_shop/ui/app_loading_view/app_loading_view.dart';
import 'package:g_shop/ui/home_view/home_view.dart';
import 'package:g_shop/ui/login_view/login_view.dart';
import 'package:g_shop/ui/my_adverts_view/my_adverts_view.dart';
import 'package:g_shop/ui/profile_editing/profile_editing_view.dart';
import 'package:g_shop/ui/profile_view/profile_view.dart';
import 'package:g_shop/ui/register_view/register_data_view.dart';
import 'package:g_shop/ui/register_view/register_view.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: AppLoadingView, initial: true, path: routerAppLoadingView),
    MaterialRoute(page: HomeView, path: routerHomeView),
    MaterialRoute(page: LogInView, path: routerLogInView),
    MaterialRoute(page: RegisterView, path: routerRegisterView),
    MaterialRoute(page: RegisterDataView, path: routerRegisterDataView),
    MaterialRoute(page: AdvertView, path: routerAdvertView),
    MaterialRoute(page: MyAdvertsView, path: routerMyAdvertsView),
    MaterialRoute(page: AdvertCreateView, path: routerAdvertCreateView),
    MaterialRoute(page: AdvertEditingView, path: routerAdvertEditingView),
    MaterialRoute(page: ProfileView, path: routerProfileView),
    MaterialRoute(page: ProfileEditingView, path: routerProfileEditingView),
  ],
)
class $Router {}