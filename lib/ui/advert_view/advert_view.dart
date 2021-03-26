import 'package:flutter/material.dart';
import 'package:g_shop/constants/colors.dart';
import 'package:g_shop/constants/localization.dart';
import 'package:g_shop/constants/strings.dart';
import 'package:g_shop/core/base/custom_view_model_builder.dart';
import 'package:g_shop/core/models/advert_model.dart';
import 'package:g_shop/ui/advert_view/advert_view_model.dart';
import 'package:g_shop/ui/utils/other_utils.dart';
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
            tooltip: textBack,
            onPressed: () => model.back(),
          ),
          title: Text(
            e.uid == model.uid ? textYourAdvert : textAdvert,
            style: Theme.of(context).textTheme.headline2,
          ),
          actions: e.uid == model.uid ? <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => model.advertEditing(e),
              tooltip: textEditYourAdvert,
            ),
          ] : e.uid != model.uid && MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ?
          <Widget>[
            TextButton(
              style: textButtonStyle(context, isWhite: true),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  textShowContact,
                  style: Theme.of(context).textTheme.headline3.copyWith(color: whiteColor),
                ),
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
                  tag: e.id + heroPhoto,
                  child: Container(
                    height: MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width,
                    color: blackColor.withOpacity(0.1),
                    child: Image.network(
                      testingImage,
                      key: UniqueKey(),
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes : null,
                          ),
                        );
                      },
                      fit: BoxFit.cover,
                      errorBuilder: (context, _, error) => Icon(
                        Icons.error_outline,
                        size: 90,
                      ),
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
                              tag: e.id + heroHeadline,
                              child: HeadlineWidget(e.headline, Theme.of(context).textTheme.headline1),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Hero(
                              tag: e.id + heroPrice,
                              child: PriceWidget(e.price.toString()),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        child: SizedBox(
                          width: double.infinity,
                          child: Hero(
                            tag:  e.id + heroDescription,
                            child: Text(e.description, style: Theme.of(context).textTheme.bodyText1),
                          ),
                        ),
                      ),
                      e.uid == model.uid ? Offstage() : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 11),
                        child: CustomButton(textShowContact, () => model.toProfile(e.uid)),
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
            Hero(
              tag: e.id + heroPhoto,
              child: Container(
                width: MediaQuery.of(context).size.height,
                color: blackColor.withOpacity(0.1),
                child: Image.network(
                  testingImage,
                  key: UniqueKey(),
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes : null,
                      ),
                    );
                  },
                  fit: BoxFit.cover,
                  errorBuilder: (context, _, error) => Icon(
                    Icons.error_outline,
                    size: 90,
                  ),
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
                            tag: e.id + heroHeadline,
                            child: HeadlineWidget(e.headline, Theme.of(context).textTheme.headline1),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Hero(
                            tag: e.id + heroPrice,
                            child: PriceWidget(e.price.toString()),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25),
                          child: SizedBox(
                            width: double.infinity,
                            child: Hero(
                              tag:  e.id + heroDescription,
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
