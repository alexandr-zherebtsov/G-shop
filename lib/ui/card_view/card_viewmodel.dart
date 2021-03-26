import 'package:g_shop/core/models/advert_model.dart';
import 'package:g_shop/core/services/advert_service.dart';
import 'package:stacked/stacked.dart';

class CardViewModel extends BaseViewModel {
  Future<void> setSave(AdvertModel e, String uid, bool isSaved) async {
    if (e.saved.length > 0) {
      for(int i = 0; i < e.saved.length; i++) {
        if(e.saved[i] == uid) {
          isSaved = true;
        }
      }
    } else {
      isSaved = false;
    }
    if (isSaved) {
      e.saved..remove(uid);
    } else {
      e.saved..add(uid);
    }
    await AdvertService().toSavedAdvert(e.id, e.toFirebase());
    notifyListeners();
  }
}
