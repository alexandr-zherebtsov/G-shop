import 'package:g_shop/generated/locator.dart';
import 'package:g_shop/ui/utils/dialog_type.dart';
import 'package:stacked_services/stacked_services.dart';

String formatMaskedPhone(String phoneNumber) {
  return phoneNumber.substring(0, 3) +
      " (" +
      phoneNumber.substring(3, 6) +
      ") " +
      phoneNumber.substring(6, 9) +
      "-" +
      phoneNumber.substring(9, 11) +
      "-" +
      phoneNumber.substring(11, phoneNumber.length);
}

String dropFormatMaskedPhone(String phoneNumber) {
  return phoneNumber
      .replaceAll("(", "")
      .replaceAll(")", "")
      .replaceAll("-", "")
      .replaceAll(" ", "")
      .trim()
      .toString();
}

Future<void> gdun(int seconds) async {
  await Future.delayed(Duration(seconds: seconds));
}

goBackNavigation({dynamic data}) {
  locator<NavigationService>().back(result: data);
}

showSnackBar(String message, {isError = false, bool goBack = false}) async {
  awaitAndBack(int seconds) async {
    if (goBack) {
      await gdun(3);
      goBackNavigation();
    }
  }

  if (isError) {
    /// TODO TESTING DIALOG
    locator<DialogService>().showCustomDialog(
      customData: DialogType.SomethingIsWrong,
      description: message,
    );
  } else {
    if (message.split(" ").isNotEmpty) {
      if (message.split(" ").length > 1) {
        var seconds = message.split(" ").length / 3 + 1.5;
        locator<SnackbarService>().showSnackbar(
            message: message, duration: Duration(seconds: seconds.toInt()));
        awaitAndBack(seconds.toInt());
      } else {
        locator<SnackbarService>()
            .showSnackbar(message: message, duration: Duration(seconds: 3));
        awaitAndBack(3);
      }
    }
  }
}