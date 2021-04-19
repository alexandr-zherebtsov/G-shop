import 'dart:math';
import 'package:flutter/material.dart';
import 'package:g_shop/constants/colors.dart';
import 'package:g_shop/generated/locator.dart';
import 'package:stacked_services/stacked_services.dart';

enum DialogType {SomethingIsWrong}

ButtonStyle textButtonStyle(BuildContext context, {bool isWhite = false}) {
  return ButtonStyle(
    overlayColor: MaterialStateColor.resolveWith(
          (states) => isWhite ? colorWhite.withOpacity(0.1) : Theme.of(context).dividerColor.withOpacity(0.1),
    ),
  );
}

void goBackNav() {
  locator<NavigationService>().back();
}

String generateId(String tag) {
  return tag + (1000 + Random().nextInt(100)).toString() + DateTime.now().toString().replaceAll(' ', '').replaceAll('+', '')
      .replaceAll('-', '').replaceAll(':', '').replaceAll(',', '').replaceAll('.', '')
      + (1000000000 + Random().nextInt(10000000)).toString();
}

String formatMaskedPhone(String phoneNumber) {
  return phoneNumber.substring(0, 3) +
      ' (' +
      phoneNumber.substring(3, 6) +
      ') ' +
      phoneNumber.substring(6, 9) +
      '-' +
      phoneNumber.substring(9, 11) +
      '-' +
      phoneNumber.substring(11, phoneNumber.length);
}

String dropFormatMaskedPhone(String phoneNumber) {
  return phoneNumber
      .replaceAll('(', '')
      .replaceAll(')', '')
      .replaceAll('-', '')
      .replaceAll(' ', '')
      .trim()
      .toString();
}

UnderlineInputBorder searchInputDecoration(BuildContext context) {
  return UnderlineInputBorder(
    borderSide: BorderSide(color: Theme.of(context).textTheme.headline2.color),
  );
}

void showSnackBar(String message, {isError = false, bool goBack = false}) async {
  awaitAndBack(int seconds) async {
    if (goBack) {
      await Future.delayed(Duration(seconds: 3));
      goBackNav();
    }
  }

  if (isError) {
    locator<DialogService>().showCustomDialog(
      customData: DialogType.SomethingIsWrong,
      description: message,
    );
  } else {
    if (message.split(' ').isNotEmpty) {
      if (message.split(' ').length > 1) {
        var seconds = message.split(' ').length / 3 + 1.5;
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