import 'package:flutter/material.dart';
import 'package:g_shop/constants/colors.dart';
import 'package:g_shop/core/base/custom_view_model_builder.dart';
import 'package:g_shop/ui/home_view/home_viewmodel.dart';
import 'package:g_shop/ui/utils/progress_screen.dart';
import 'package:g_shop/ui/utils/scroll_custom.dart';
import 'package:g_shop/ui/widgets/card_widget.dart';
import 'package:g_shop/ui/widgets/exception_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilderConnect<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, _) => model.isBusy? ProgressScreen() : ResponsiveBuilder(
        builder: (context, sizingInformation) => Scaffold(
          appBar: AppBar(
            title: Text('Home', style: Theme.of(context).textTheme.headline2),
            leading: null,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.person),
                onPressed: () => model.toMyProfile(),
                tooltip: 'Your Profile',
              ),
            ],
          ),
          body: model.adverts == null || model.adverts.isEmpty ?
          ExceptionWidget(
            title: 'No adverts',
            img: 'assets/images/guitar_vector.png',
            isError: false,
          ) : ScrollConfiguration(
            behavior: MyBehavior(),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: sizingInformation.isTablet || sizingInformation.isDesktop ?
                const EdgeInsets.symmetric(horizontal: 10.0) : const EdgeInsets.symmetric(horizontal: 3.0),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 90),
                  child: Wrap(
                    children: model.adverts.map((e) => CardWidget(e: e)).toList(),
                  ),
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            heroTag: 'buttonCreateAdvert',
            backgroundColor: Theme.of(context).buttonColor,
            tooltip: 'Create Advert',
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).buttonColor,
                borderRadius: BorderRadius.all(Radius.circular(100)),
                boxShadow: [
                  BoxShadow(
                    color: blackGrayColor.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 3,
                  ),
                ],
              ),
              child: Icon(
                Icons.add,
                color: Theme.of(context).iconTheme.color,
                size: 40,
              ),
            ),
            onPressed: () => model.toAdvertCreate(),
          ),
        ),
      ),
    );
  }
}
