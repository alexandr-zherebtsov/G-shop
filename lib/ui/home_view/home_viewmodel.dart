import 'package:firebase_auth/firebase_auth.dart';
import 'package:g_shop/constants/strings.dart';
import 'package:g_shop/generated/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  String currentUserUid = FirebaseAuth.instance.currentUser.uid;

  void toAdvertCreate() {
    locator<NavigationService>().navigateTo(routerAdvertCreateView);
  }

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  bool _reverse = false;
  bool get reverse => _reverse;

  void getIndexPage(int indexPage) {
    _currentIndex = indexPage;
  }

  void setIndex(int value) {
    if (value < _currentIndex) {
      _reverse = true;
    } else {
      _reverse = false;
    }
    _currentIndex = value;
    notifyListeners();
  }

  bool isIndexSelected(int index) => _currentIndex == index;
}
