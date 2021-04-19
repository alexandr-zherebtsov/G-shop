import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:g_shop/constants/colors.dart';
import 'package:g_shop/constants/localization.dart';
import 'package:g_shop/constants/strings.dart';
import 'package:g_shop/core/base/custom_view_model_builder.dart';
import 'package:g_shop/ui/all_adverts_view/all_adverts_view.dart';
import 'package:g_shop/ui/home_view/home_viewmodel.dart';
import 'package:g_shop/ui/my_adverts_view/my_adverts_view.dart';
import 'package:g_shop/ui/profile_view/profile_view.dart';
import 'package:g_shop/ui/saved_advert_view/saved_adverts_view.dart';
import 'package:g_shop/ui/utils/progress_screen.dart';
import 'package:g_shop/ui/widgets/other_widgets.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeView extends StatelessWidget {
  final int pageIndex;
  HomeView({Key key, this.pageIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilderConnect<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) => model.getIndexPage(pageIndex),
      builder: (context, model, _) => model.isBusy? ProgressScreen() : ResponsiveBuilder(
        builder: (context, sizingInformation) => Scaffold(
          body: PageTransitionSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (
                Widget child,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                ) =>
                FadeThroughTransition(
                  animation: animation,
                  fillColor: Theme.of(context).scaffoldBackgroundColor,
                  secondaryAnimation: secondaryAnimation,
                  child: child,
                ),
            child: getTab(model.currentIndex, model.currentUserUid),
          ),
          floatingActionButton: model.currentIndex == 3 ? null : Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              boxShadow: [
                BoxShadow(
                  color: colorBlack.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                ),
              ],
            ),
            child: FloatingActionButton(
              elevation: 0.0,
              focusElevation: 0.0,
              hoverElevation: 0.0,
              disabledElevation: 0.0,
              highlightElevation: 0.0,
              heroTag: heroButtonCreateAdvert,
              backgroundColor: Theme.of(context).buttonColor,
              tooltip: textCreateAdvert,
              child: Icon(
                Icons.add,
                color: Theme.of(context).iconTheme.color,
                size: 40,
              ),
              onPressed: () => model.toAdvertCreate(),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            elevation: 12.0,
            backgroundColor: Theme.of(context).appBarTheme.color,
            currentIndex: model.currentIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: colorWhite,
            unselectedItemColor: colorWhite,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: model.setIndex,
            selectedLabelStyle: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 13.0),
            unselectedLabelStyle: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 12.0),
            items: [
              BottomNavigationBarItem(
                icon: unselectedNavBarIcon(context, Icons.assignment_outlined),
                activeIcon: selectedNavBarIcon(context, Icons.assignment),
                label: textAllAdverts,
              ),
              BottomNavigationBarItem(
                icon: unselectedNavBarIcon(context, Icons.bookmark_border),
                activeIcon: selectedNavBarIcon(context, Icons.bookmark),
                label: textSaved,
              ),
              BottomNavigationBarItem(
                icon: unselectedNavBarIcon(context, Icons.assignment_ind_outlined),
                activeIcon: selectedNavBarIcon(context, Icons.assignment_ind),
                label: textMyAdverts,
              ),
              BottomNavigationBarItem(
                icon: unselectedNavBarIcon(context, Icons.person_outline),
                activeIcon: selectedNavBarIcon(context, Icons.person),
                label: textProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getTab(int index, String currentUserUid) {
    if (index == 1) return SavedAdvertsView();
    if (index == 2) return MyAdvertsView();
    if (index == 3) return ProfileView(uid: currentUserUid);
    return AllAdvertsView();
  }
}
