import 'package:g_shop/core/managers/dio_manager.dart';
import 'package:g_shop/core/services/advert_service.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_themes/stacked_themes.dart';

@module
abstract class ThirdPartyServicesModule {
  @lazySingleton
  NavigationService get navigationService;

  @lazySingleton
  DialogService get dialogService;

  @lazySingleton
  SnackbarService get snackBarService;

  @lazySingleton
  DioManager get dioManager;

  @lazySingleton
  ThemeService get themeService;

  @lazySingleton
  AdvertService get advertService;

}