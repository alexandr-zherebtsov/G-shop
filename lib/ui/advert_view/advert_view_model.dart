import 'package:g_shop/generated/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AdvertViewModel extends FutureViewModel {

  @override
  Future futureToRun() async {
    await init();
  }

  init() async {

  }

  void back() {
    locator<NavigationService>().back();
  }

  void profile() {
    locator<NavigationService>().navigateTo('/profile');
  }

  void advertEditing() {
    locator<NavigationService>().navigateTo('/advert_editing');
  }
}