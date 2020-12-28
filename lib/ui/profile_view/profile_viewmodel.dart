import 'package:g_shop/generated/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileViewModel extends FutureViewModel {

  bool _num = true;
  bool get num => _num;

  set numCheck(bool num) {
    _num = num;
    notifyListeners();
  }

  numFun (String phoneNumber) {
    if (num) {
      launch('tel://$phoneNumber');
      numCheck = false;
      print('Click');
    } else {
      print('Excess click');
    }
    Future.delayed(const Duration(seconds: 2), () {
      numCheck = true;
      print('Did new click');
    });
  }

  @override
  Future futureToRun() async {
    await init();
  }

  init() async {

  }

  void back() {
    locator<NavigationService>().back();
  }
}