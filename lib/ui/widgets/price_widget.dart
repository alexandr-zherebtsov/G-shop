import 'package:flutter/material.dart';
import 'package:g_shop/constants/colors.dart';

class PriceWidget extends StatelessWidget {
  final String title;
  const PriceWidget(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: 90,
        minHeight: 25,
        maxWidth: 100,
      ),
      decoration: BoxDecoration(
        color: lightGreen,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          '$title \$',
          style: Theme.of(context).textTheme.headline3.copyWith(color: whiteColor),
        ),
      ),
    );
  }
}
