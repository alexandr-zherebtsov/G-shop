import 'package:flutter/material.dart';
import 'package:g_shop/constants/colors.dart';
import 'package:g_shop/core/base/custom_view_model_builder.dart';
import 'package:g_shop/core/models/advert_model.dart';
import 'package:g_shop/ui/advert_view/advert_view_model.dart';
import 'package:g_shop/ui/utils/scroll_custom.dart';
import 'package:g_shop/ui/widgets/custom_button_widget.dart';
import 'package:g_shop/ui/widgets/headline_widget.dart';
import 'package:g_shop/ui/widgets/price_widget.dart';

class AdvertView extends StatelessWidget {
  final AdvertModel e;
  const AdvertView({Key key, this.e}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilderConnect<AdvertViewModel>.reactive(
      viewModelBuilder: () => AdvertViewModel(),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            tooltip: 'Back',
            onPressed: () => model.back(),
          ),
          title: Text(
            e.uid == model.uid ? 'Your Advert' : 'Advert',
            style: Theme.of(context).textTheme.headline2,
          ),
          actions: e.uid == model.uid ? <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => model.advertEditing(),
              tooltip: 'Edit Your Advert',
            ),
          ] : e.uid != model.uid && MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ?
          <Widget>[
            FlatButton(
              child: Text(
                'Show Contact',
                style: Theme.of(context).textTheme.headline3.copyWith(color: whiteColor),
              ),
              onPressed: () => model.toProfile(e.uid),
            ),
          ] : null,
        ),
        body: MediaQuery.of(context).size.width < MediaQuery.of(context).size.height ? ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Hero(
                  tag: e.id + 'photo',
                  child: Container(
                    color: blackColor.withOpacity(0.1),
                    height: MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      'assets/images/guitar.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width - 130,
                            ),
                            child: Hero(
                              tag: e.id + 'headline',
                              child: HeadlineWidget(e.headline, Theme.of(context).textTheme.headline1),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Hero(
                              tag: e.id + 'price',
                              child: PriceWidget(e.prise.toString()),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        child: SizedBox(
                          width: double.infinity,
                          child: Hero(
                            tag:  e.id + 'description',
                            child: Text(e.description, style: Theme.of(context).textTheme.bodyText1),
                          ),
                        ),
                      ),
                      e.uid == model.uid ? Offstage() : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 11),
                        child: CustomButtonWidget('Show Contact', () => model.toProfile(e.uid)),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ),
        ) : Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: blackColor.withOpacity(0.1),
              width: MediaQuery.of(context).size.height,
              child: Hero(
                tag: e.id + 'photo',
                child: Image.asset(
                  'assets/images/guitar.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width - (MediaQuery.of(context).size.height + 20),
                          ),
                          child: Hero(
                            tag: e.id + 'headline',
                            child: HeadlineWidget(e.headline, Theme.of(context).textTheme.headline1),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Hero(
                            tag: e.id + 'price',
                            child: PriceWidget(e.prise.toString()),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25),
                          child: SizedBox(
                            width: double.infinity,
                            child: Hero(
                              tag:  e.id + 'description',
                              child: Text(e.description, style: Theme.of(context).textTheme.bodyText1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
