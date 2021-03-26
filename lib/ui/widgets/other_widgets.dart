import 'package:flutter/material.dart';

Widget unselectedNavBarIcon(BuildContext context, IconData icon) {
  return Icon(icon, color: Theme.of(context).appBarTheme.iconTheme.color, size: 27.0);
}

Widget selectedNavBarIcon(BuildContext context, IconData icon) {
  return Icon(icon, color: Theme.of(context).appBarTheme.iconTheme.color, size: 29.0);
}
