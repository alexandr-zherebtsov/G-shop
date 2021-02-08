import 'package:flutter/material.dart';
import 'package:g_shop/constants/colors.dart';
import 'package:g_shop/constants/strings.dart';
import 'package:g_shop/core/models/advert_model.dart';
import 'package:g_shop/generated/locator.dart';
import 'package:g_shop/generated/router.gr.dart';
import 'package:g_shop/ui/widgets/headline_widget.dart';
import 'package:g_shop/ui/widgets/price_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked_services/stacked_services.dart';

class CardWidget extends StatelessWidget {
  final AdvertModel e;
  const CardWidget({Key key, this.e}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Container(
        height: 150,
        width: MediaQuery.of(context).size.width > MediaQuery.of(context).size.height &&
            sizingInformation.isMobile ?
        MediaQuery.of(context).size.width / 2 - 3 :
        MediaQuery.of(context).size.width > MediaQuery.of(context).size.height
            && sizingInformation.isDesktop || sizingInformation.isTablet ?
        MediaQuery.of(context).size.width / 2 - 10 : double.infinity,
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
                    child: Hero(
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
    );
  }
}
