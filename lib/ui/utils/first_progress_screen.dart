import 'package:flutter/material.dart';
import 'package:g_shop/constants/colors.dart';
import 'package:g_shop/constants/strings.dart';
import 'package:g_shop/core/base/custom_view_model_builder.dart';
import 'package:stacked/stacked.dart';

class FirstProgressScreen extends StatefulWidget {
  final Brightness brightness;
  const FirstProgressScreen({Key key, this.brightness}) : super(key: key);

  @override
  _FirstProgressScreenState createState() => _FirstProgressScreenState();
}

class _FirstProgressScreenState extends State<FirstProgressScreen> with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(milliseconds: 1300),
      vsync: this,
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn),
    );
    animationController.forward();
  }

  @override
  dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilderConnect<FirstProgressScreenViewModel>.reactive(
      viewModelBuilder: () => FirstProgressScreenViewModel(),
      onModelReady: (vm) => vm.initColor(widget.brightness, Theme.of(context).scaffoldBackgroundColor),
      builder: (context, model, _) => AnimatedContainer(
        duration: Duration(milliseconds: 1800),
        curve: Curves.fastOutSlowIn,
        color: model.bgColor,
        padding: const EdgeInsets.only(top: 16.0),
        child: FadeTransition(
          opacity: animationController.drive(CurveTween(curve: Curves.fastOutSlowIn)),
          child: Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  bottom: -4,
                  right: -4,
                  child: Container(
                    width: MediaQuery.of(context).size.width < MediaQuery.of(context).size.height ?
                    MediaQuery.of(context).size.width - 112 : MediaQuery.of(context).size.height - 72,
                    height: MediaQuery.of(context).size.width < MediaQuery.of(context).size.height ?
                    MediaQuery.of(context).size.width - 112 : MediaQuery.of(context).size.height - 72,
                    constraints: BoxConstraints(
                      maxWidth: 508,
                      maxHeight: 508,
                    ),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(firstProgressLightGreen),
                      strokeWidth: 10,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width < MediaQuery.of(context).size.height ?
                  MediaQuery.of(context).size.width - 120 : MediaQuery.of(context).size.height - 80,
                  height: MediaQuery.of(context).size.width < MediaQuery.of(context).size.height ?
                  MediaQuery.of(context).size.width - 120 : MediaQuery.of(context).size.height - 80,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  constraints: BoxConstraints(
                    maxWidth: 500,
                    maxHeight: 500,
                  ),
                  child: Image.asset(imgBigLogo),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FirstProgressScreenViewModel extends BaseViewModel {
  Color bgColor = whiteColor;

  initColor(Brightness brightness, Color scaffoldBackgroundColor) async {
    bgColor = brightness == Brightness.dark ? mediumGray : whiteColor;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 400));
    bgColor = scaffoldBackgroundColor;
    notifyListeners();
  }
}
