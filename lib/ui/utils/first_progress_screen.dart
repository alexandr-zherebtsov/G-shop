import 'package:flutter/material.dart';
import 'package:g_shop/constants/colors.dart';

class FirstProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: grayColor_3,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(lightGreen),
        ),
      ),
    );
  }
}
