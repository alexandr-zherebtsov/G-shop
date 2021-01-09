import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final String title;
  final Function onPressed;
  const CustomButtonWidget(this.title, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      minWidth: 176,
      color: Theme.of(context).buttonColor,
      child: Text(title, style: Theme.of(context).textTheme.button),
      onPressed: onPressed,
    );
  }
}
