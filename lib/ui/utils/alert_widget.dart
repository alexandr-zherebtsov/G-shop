import 'package:flutter/material.dart';
import 'package:g_shop/constants/colors.dart';
import 'package:g_shop/generated/locator.dart';
import 'package:stacked_services/stacked_services.dart';

void showAlert(BuildContext context, String headline, String title, Function function) {
  assert(context != null);
  assert(headline != null);
  assert(title != null);
  assert(function != null);

  showDialog(barrierDismissible: false, context: context, builder: (context) {
    return AlertDialog(
      title: Text(headline, style: Theme.of(context).textTheme.headline4),
      content: Text(title),
      actions: [
        FlatButton(
          child: Text('Cancel', style: Theme.of(context).textTheme.bodyText1),
          splashColor: transparentLightGreen,
          onPressed: () => locator<NavigationService>().back(),
        ),
        FlatButton(
          child: Text('Delete', style: Theme.of(context).textTheme.bodyText1.copyWith(color: redColor)),
          splashColor: transparentLightGreen,
          onPressed: function,
        ),
      ],
    );
  });
}
