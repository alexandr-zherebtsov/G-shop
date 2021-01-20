import 'package:flutter/material.dart';
import 'package:g_shop/constants/colors.dart';
import 'package:g_shop/core/base/custom_view_model_builder.dart';
import 'package:g_shop/ui/app_loading_view/app_loading_viewmodel.dart';
import 'package:g_shop/ui/utils/first_progress_screen.dart';

class AppLoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    return ViewModelBuilderConnect<AppLoadingViewModel>.reactive(
      viewModelBuilder: () => AppLoadingViewModel(),
      onModelReady: (vm) => vm.init(),
      builder: (context, model, _) => FutureBuilder(
        future: Future.delayed(Duration(milliseconds: 200)),
        builder: (c, s) => s.connectionState == ConnectionState.done
            ? FirstProgressScreen(brightness: brightness)
            : Container(
          color: brightness == Brightness.dark ? mediumGray : whiteColor,
        ),
      ),
    );
  }
}
