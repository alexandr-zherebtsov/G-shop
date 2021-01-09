import 'package:flutter/material.dart';
import 'package:g_shop/constants/colors.dart';
import 'package:g_shop/core/base/custom_view_model_builder.dart';
import 'package:g_shop/generated/locator.dart';
import 'package:g_shop/ui/utils/first_progress_screen.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AppLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    return ViewModelBuilderConnect<AppLoadingViewModel>.reactive(
      viewModelBuilder: () => AppLoadingViewModel(),
      builder: (context, model, _) => FutureBuilder(
        future: Future.delayed(Duration(milliseconds: 300)),
        builder: (c, s) => s.connectionState == ConnectionState.done
            ? FirstProgressScreen(brightness: brightness) : Container(
          color: brightness == Brightness.dark ? mediumGray : whiteColor,
        ),
      ),
    );
  }
}

class AppLoadingViewModel extends FutureViewModel {
  @override
  Future futureToRun() async {
    await Future.delayed(Duration(milliseconds: 2600));
    toCheckLogin();
  }

  void toCheckLogin() {
    locator<NavigationService>().clearStackAndShow('/check_login');
  }
}
