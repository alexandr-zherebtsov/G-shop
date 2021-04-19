import 'package:flutter/material.dart';
import 'package:g_shop/constants/colors.dart';
import 'package:g_shop/constants/localization.dart';
import 'package:g_shop/constants/strings.dart';
import 'package:g_shop/core/base/custom_view_model_builder.dart';
import 'package:g_shop/ui/card_view/card_view.dart';
import 'package:g_shop/ui/my_adverts_view/my_adverts_viewmodel.dart';
import 'package:g_shop/ui/utils/other_utils.dart';
import 'package:g_shop/ui/utils/progress_screen.dart';
import 'package:g_shop/ui/utils/scroll_custom.dart';
import 'package:g_shop/ui/widgets/exception_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MyAdvertsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilderConnect<MyAdvertsViewModel>.reactive(
      viewModelBuilder: () => MyAdvertsViewModel(),
      builder: (context, model, _) => model.isBusy ? ProgressScreen() : ResponsiveBuilder(
        builder: (context, sizingInformation) => Scaffold(
          appBar: AppBar(
            title: model.isSearch ? Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextField(
                autofocus: true,
                controller: model.searchTextController,
                cursorColor: Theme.of(context).textTheme.headline2.color,
                style: Theme.of(context).textTheme.bodyText1.copyWith(color: colorWhite),
                onChanged: (v) => model.onChangedSearch(),
                decoration: InputDecoration(
                  border: searchInputDecoration(context),
                  disabledBorder: searchInputDecoration(context),
                  enabledBorder: searchInputDecoration(context),
                  focusedBorder: searchInputDecoration(context),
                ),
              ),
            ) : Text(textMyAdverts, style: Theme.of(context).textTheme.headline2),
            automaticallyImplyLeading: false,
            actions: <Widget>[
              model.isSearch ? IconButton(
              icon: Icon(Icons.clear),
              onPressed: () => model.clearSearch(),
              tooltip: textSearch,
            ) : IconButton(
                icon: Icon(Icons.search),
                onPressed: () => model.activateSearch(),
                tooltip: textSearch,
              ),
            ],
          ),
          body: model.myAdverts == null || model.myAdverts.isEmpty ?
          ExceptionWidget(
            title: textYouHaveNoAdverts,
            img: imgGuitarVector,
            isError: false,
          ) : model.mySearchedAdverts.isEmpty && model.searchTextController.text.isNotEmpty ? ExceptionWidget(
            title: textNoResults,
            img: imgGuitarVector,
            isError: false,
          ) : model.searchTextController.text.isEmpty ? ScrollConfiguration(
            behavior: MyBehavior(),
            child: SingleChildScrollView(
              child: Padding(
                padding: sizingInformation.isTablet || sizingInformation.isDesktop ?
                const EdgeInsets.symmetric(horizontal: 10.0) : const EdgeInsets.symmetric(horizontal: 3.0),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 90),
                  child: Wrap(
                    children: model.myAdverts.map((e) => CardView(e: e, uid: model.currentUserUid)).toList(),
                  ),
                ),
              ),
            ),
          ) : ScrollConfiguration(
            behavior: MyBehavior(),
            child: SingleChildScrollView(
              child: Padding(
                padding: sizingInformation.isTablet || sizingInformation.isDesktop ?
                const EdgeInsets.symmetric(horizontal: 10.0) : const EdgeInsets.symmetric(horizontal: 3.0),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 90),
                  child: Wrap(
                    children: model.mySearchedAdverts.map((e) => CardView(e: e, uid: model.currentUserUid)).toList(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
