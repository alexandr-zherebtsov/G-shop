import 'package:g_shop/generated/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends FutureViewModel {

  @override
  Future futureToRun() async {
    await init();
  }

  init() async {

  }

  void myProfile() {
    locator<NavigationService>().navigateTo('/my_profile');
  }

  void advert() {
    locator<NavigationService>().navigateTo('/advert');
  }

  void advertCreate() {
    locator<NavigationService>().navigateTo('/advert_create');
  }
}