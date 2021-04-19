import 'package:flutter/material.dart';
import 'package:g_shop/constants/colors.dart';
import 'package:g_shop/constants/localization.dart';
import 'package:g_shop/ui/utils/other_utils.dart';

void showAlert(BuildContext context, String headline, String title, Function function, {isLogOut = false}) {
  assert(context != null);
  assert(headline != null);
  assert(title != null);
  assert(function != null);

  showDialog(barrierDismissible: false, context: context, builder: (context) {
    return AlertDialog(
      title: Text(headline, style: Theme.of(context).textTheme.headline4),
      content: Text(title),
      actions: [
        TextButton(
          style: textButtonStyle(context),
          child: Text(textCancel, style: Theme.of(context).textTheme.bodyText1),
          onPressed: () => goBackNav(),
        ),
        TextButton(
          style: textButtonStyle(context),
          child: Text(isLogOut ? textYes : textDelete, style: Theme.of(context).textTheme.bodyText1.copyWith(color: colorRed)),
          onPressed: function,
        ),
      ],
    );
  });
}

void showPasswordAlert(
    BuildContext context,
    String headline,
    String title,
    Function function,
    TextEditingController passwordController,
    GlobalKey<FormState> formKey,
    ) {
  showDialog(barrierDismissible: false, context: context, builder: (context) {
    return Form(
      key: formKey,
      child: AlertDialog(
        title: Text(headline, style: Theme.of(context).textTheme.headline4),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title),
            TextFormField(
              controller: passwordController,
              keyboardType: TextInputType.text,
              cursorColor: Theme.of(context).accentColor,
              autocorrect: false,
              obscureText: true,
              autofocus: true,
              decoration: const InputDecoration(
                icon: const Icon(Icons.lock),
                labelText: textPassword,
              ),
              validator: (v) {
                if (v.isEmpty) {
                  return textNotBeEmpty;
                } else if (v.length < 4) {
                  return text4Characters;
                } else {
                  return null;
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            style: textButtonStyle(context),
            child: Text(textCancel, style: Theme.of(context).textTheme.bodyText1),
            onPressed: () {
              passwordController.clear();
              goBackNav();
            },
          ),
          TextButton(
            style: textButtonStyle(context),
            child: Text(textDelete, style: Theme.of(context).textTheme.bodyText1.copyWith(color: colorRed)),
            onPressed: function,
          ),
        ],
      ),
    );
  });
}