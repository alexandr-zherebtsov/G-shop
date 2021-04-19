import 'package:g_shop/constants/colors.dart';
import 'package:g_shop/constants/localization.dart';
import 'package:g_shop/constants/strings.dart';
import 'package:g_shop/core/models/advert_model.dart';
import 'package:g_shop/core/services/advert_service.dart';
import 'package:g_shop/generated/locator.dart';
import 'package:g_shop/generated/router.gr.dart';
import 'package:g_shop/ui/utils/toast_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CardViewModel extends BaseViewModel {
  Future<bool> setSave(AdvertModel e, String uid, bool isSaved) async {
    if (e.saved.length > 0) {
      for (int i = 0; i < e.saved.length; i++) {
        if (e.saved[i] == uid) {
          isSaved = true;
        }
      }
    } else {
      isSaved = false;
    }
    if (isSaved) {
      e.saved..remove(uid);
      isSaved = false;
      showToast(textRemovedFromSaved, colorLightGreen.withOpacity(0.75), colorWhite);
    } else {
      e.saved..add(uid);
      isSaved = true;
      showToast(textAddedToSaved, colorLightGreen.withOpacity(0.75), colorWhite);
    }
    await AdvertService().toSavedAdvert(e.id, e.toFirebase());
    return isSaved;
  }

  void toAdvertView(AdvertModel e) {
    locator<NavigationService>().navigateTo(routerAdvertView, arguments: AdvertViewArguments(e: e));
  }
}
