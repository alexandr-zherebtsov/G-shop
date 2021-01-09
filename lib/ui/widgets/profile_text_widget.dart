import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProfileTextWidget extends StatelessWidget {
  final String title;
  final String text;
  const ProfileTextWidget(this.title, this.text);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.headline3),
          Padding(
            padding: sizingInformation.isTablet || sizingInformation.isDesktop ?
            const EdgeInsets.only(top: 20.0, bottom: 35.0) : const EdgeInsets.only(top: 10.0, bottom: 25.0),
            child: Text(text, style: Theme.of(context).textTheme.headline3),
          ),
        ],
      ),
    );
  }
}
