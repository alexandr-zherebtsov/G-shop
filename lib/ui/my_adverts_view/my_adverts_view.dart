import 'package:flutter/material.dart';
import 'package:g_shop/constants/colors.dart';
import 'package:g_shop/core/base/custom_view_model_builder.dart';
import 'package:g_shop/ui/my_adverts_view/my_adverts_viewmodel.dart';
import 'package:g_shop/ui/utils/progress_screen.dart';
import 'package:g_shop/ui/utils/scroll_custom.dart';
import 'package:g_shop/ui/widgets/card_widget.dart';
import 'package:g_shop/ui/widgets/no_adverts_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MyAdvertsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilderConnect<MyAdvertsViewModel>.reactive(
      viewModelBuilder: () => MyAdvertsViewModel(),
      builder: (context, model, _) => model.isBusy? ProgressScreen() : ResponsiveBuilder(
        builder: (context, sizingInformation) => Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              tooltip: 'Back',
              onPressed: () => model.back(),
            ),
            title: Text('Your Adverts', style: Theme.of(context).textTheme.headline2),
          ),
          body: model.myAdverts == null || model.myAdverts.isEmpty ?
          NoAdvertsWidget(title: 'You have no adverts') : ScrollConfiguration(
            behavior: MyBehavior(),
            child: SingleChildScrollView(
              child: Padding(
                padding: sizingInformation.isTablet || sizingInformation.isDesktop ?
                const EdgeInsets.symmetric(horizontal: 10.0) : EdgeInsets.zero,
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Wrap(
                      children: model.myAdverts.map((e) => CardWidget(e: e)).toList(),
                    ),
                    SizedBox(height: 90),
                  ],
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
                    spreadRadius: 4,
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Icon(
                Icons.add,
                color: Theme.of(context).iconTheme.color,
                size: 40,
              ),
            ),
            onPressed: () => model.advertCreate(),
          ),
        ),
      ),
    );
  }
}
