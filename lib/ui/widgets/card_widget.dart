import 'package:flutter/material.dart';
import 'package:g_shop/constants/colors.dart';
import 'package:g_shop/ui/widgets/headline_widget.dart';
import 'package:g_shop/ui/widgets/price_widget.dart';

class CardWidget extends StatelessWidget {

  final int id;
  final String img;
  final String headline;
  final String description;
  final String price;
  final Function onTap;
  const CardWidget(this.id, this.img, this.headline, this.description, this.price, this.onTap);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Card(
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Hero(
                    tag: '$id$img',
                    child: Container(
                      height: 140,
                      width: 140,
                      color: blackColor.withOpacity(0.1),
                      child: Image.asset(
                        img,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                SizedBox(
                  height: 140,
                  width: MediaQuery.of(context).size.width - 175,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: '$id$headline',
                        child: HeadlineWidget(headline, Theme.of(context).textTheme.headline1),
                      ),
                      Hero(
                        tag: '$id$description',
                        child: Text(
                          description,
                          style: Theme.of(context).textTheme.bodyText2,
                          softWrap: true,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Hero(
                          tag: '$id$price',
                          child: PriceWidget(price),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

