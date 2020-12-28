import 'package:flutter/material.dart';

class HeadlineWidget extends StatelessWidget {

  final String title;
  final TextStyle textStyle;
  const HeadlineWidget(this.title, this.textStyle);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: textStyle,
      softWrap: false,
      overflow: TextOverflow.fade,
    );
  }
}