import 'package:flutter/material.dart';
import 'package:g_shop/constants/colors.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  const CustomButton(this.title, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0.5,
      focusElevation: 0.8,
      highlightElevation: 0.8,
      disabledElevation: 0.5,
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      minWidth: 176,
      colorBrightness: brightnessDark,
      color: Theme.of(context).buttonColor,
      child: Text(title, style: Theme.of(context).textTheme.button),
      onPressed: onPressed,
    );
  }
}

class AddPhotoButton extends StatelessWidget {
  final Function onPressed;
  const AddPhotoButton(this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 58,
      margin: const EdgeInsets.all(4.0),
      child: MaterialButton(
        minWidth: 58,
        height: 58,
        elevation: 0.5,
        focusElevation: 0.8,
        highlightElevation: 0.8,
        disabledElevation: 0.5,
        padding: EdgeInsets.zero,
        colorBrightness: brightnessDark,
        color: Theme.of(context).buttonColor,
        child: Center(
          child: Icon(
            Icons.add,
            size: 50,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
