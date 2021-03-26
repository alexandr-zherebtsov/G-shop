import 'package:decorated_icon/decorated_icon.dart';
import 'package:flutter/material.dart';
import 'package:g_shop/constants/colors.dart';
import 'package:g_shop/constants/localization.dart';
import 'package:g_shop/constants/strings.dart';
import 'package:g_shop/core/base/custom_view_model_builder.dart';
import 'package:g_shop/core/models/advert_model.dart';
import 'package:g_shop/generated/locator.dart';
import 'package:g_shop/generated/router.gr.dart';
import 'package:g_shop/ui/card_view/card_viewmodel.dart';
import 'package:g_shop/ui/utils/toast_widget.dart';
import 'package:g_shop/ui/widgets/headline_widget.dart';
import 'package:g_shop/ui/widgets/price_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked_services/stacked_services.dart';

class CardView extends StatelessWidget {
  final AdvertModel e;
  final String uid;
  const CardView({Key key, this.e, this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSaved = false;
    if (e.saved.length > 0) {
      for(int i = 0; i < e.saved.length; i++) {
        if(e.saved[i] == uid) {
          isSaved = true;
        }
      }
    } else {
      isSaved = false;
    }
    return ViewModelBuilderConnect<CardViewModel>.reactive(
      viewModelBuilder: () => CardViewModel(),
      builder: (context, model, _) => ResponsiveBuilder(
        builder: (context, sizingInformation) => Container(
          height: 150,
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.all(3.0),
          width: MediaQuery.of(context).size.width > MediaQuery.of(context).size.height &&
              sizingInformation.isMobile ?
          MediaQuery.of(context).size.width / 2 - 9 :
          MediaQuery.of(context).size.width > MediaQuery.of(context).size.height
              && sizingInformation.isDesktop || sizingInformation.isTablet ?
          MediaQuery.of(context).size.width / 2 - 16 : double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: blackColor.withOpacity(0.01),
                spreadRadius: 0.0,
                blurRadius: 0.0,
                offset: Offset.zero,
              ),
            ],
          ),
          child: Card(
            margin: const EdgeInsets.all(3.0),
            child: InkWell(
              onTap: () => locator<NavigationService>().navigateTo(routerAdvertView, arguments: AdvertViewArguments(e: e)),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Stack(
                        children: [
                          Hero(
                            tag: e.id + heroPhoto,
                            child: Container(
                              height: 140,
                              width: 140,
                              color: blackColor.withOpacity(0.1),
                              child: Image.network(
                                testingImage,
                                key: UniqueKey(),
                                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
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
                          uid == e.uid ? Offstage() : InkWell(
                            highlightColor: transparentColor,
                            splashColor: transparentColor,
                            focusColor: transparentColor,
                            hoverColor: transparentColor,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: DecoratedIcon(
                                isSaved ? Icons.bookmark : Icons.bookmark_outline,
                                size: 29,
                                shadows: [
                                  BoxShadow(
                                    blurRadius: 12.0,
                                    color: blackColor.withOpacity(0.3),
                                    offset: Offset(0, 2.0),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () async {
                              await model.setSave(e, uid, isSaved);
                              if (e.saved.length > 0) {
                                for(int i = 0; i < e.saved.length; i++) {
                                  if(e.saved[i] == uid) {
                                    isSaved = true;
                                    showToast(textAddedToSaved, lightGreen.withOpacity(0.75), whiteColor);
                                  }
                                }
                              } else {
                                isSaved = false;
                                showToast(textRemovedFromSaved, lightGreen.withOpacity(0.75), whiteColor);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: SizedBox(
                        height: 140,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Hero(
                              tag: e.id + heroHeadline,
                              child: HeadlineWidget(e.headline, Theme.of(context).textTheme.headline1),
                            ),
                            Hero(
                              tag: e.id + heroDescription,
                              child: Text(
                                e.description,
                                style: Theme.of(context).textTheme.bodyText2,
                                softWrap: true,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Hero(
                                tag: e.id + heroPrice,
                                child: PriceWidget(e.price.toString()),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}