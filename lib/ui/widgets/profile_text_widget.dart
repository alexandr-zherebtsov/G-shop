import 'package:flutter/material.dart';

class ProfileTextWidget extends StatelessWidget {

  final String title;
  final String text;
  const ProfileTextWidget(this.title, this.text);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headline3),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 25.0),
          child: Text(text, style: Theme.of(context).textTheme.headline3),
        ),
      ],
    );
  }
}