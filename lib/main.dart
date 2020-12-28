import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:g_shop/constants/themes.dart';
import 'package:g_shop/core/servises/dependency_injection.dart';
import 'package:g_shop/generated/locator.dart';
import 'package:g_shop/generated/router.gr.dart' as auto_router;
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_themes/stacked_themes.dart';

Future main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  debugPaintSizeEnabled = false;
  await ThemeManager.initialise();
  WidgetsFlutterBinding.ensureInitialized();
  await InjectorDI().configure(Flavor.DEV);
  setupLocator();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      themes: getThemes(),
      builder: (context, darkTheme, lightTheme, themeMode) => MaterialApp(
        title: 'G-shop',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: auto_router.Router().onGenerateRoute,
        navigatorKey: locator<NavigationService>().navigatorKey,
        theme: darkTheme,
        darkTheme: lightTheme,
        themeMode: themeMode,
      ),
    );
  }
}
