import 'package:firebase_auth/firebase_auth.dart';
import 'package:g_shop/constants/strings.dart';
import 'package:g_shop/generated/locator.dart';
import 'package:g_shop/generated/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AdvertViewModel extends BaseViewModel {
  String uid = FirebaseAuth.instance.currentUser.uid;

  void toAdvert() {
    locator<NavigationService>().navigateTo(routerAdvertView);
  }

  void back() {
    locator<NavigationService>().back();
  }

  void toProfile(uid) {
    locator<NavigationService>().navigateTo(routerProfileView, arguments: ProfileViewArguments(uid: uid));
  }

  void advertEditing(String headline, int price, String description) {
    locator<NavigationService>().navigateTo(
      routerAdvertEditingView,
      arguments: AdvertEditingViewArguments(
        headline: headline,
        price: price,
        description: description,
      ),
    );
  }
}
