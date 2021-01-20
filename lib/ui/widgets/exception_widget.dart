import 'package:flutter/material.dart';
import 'package:g_shop/ui/widgets/headline_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ExceptionWidget extends StatelessWidget {
  final String title;
  final String img;
  final bool isError;

  const ExceptionWidget({
    Key key,
    this.title,
    this.img,
    this.isError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Center(
        child: Padding(
          padding: isError ? const EdgeInsets.only(top: 80.0) : EdgeInsets.zero,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HeadlineWidget(
                title,
                Theme.of(context).textTheme.headline1.copyWith(
                  color: Theme.of(context).textTheme.headline1.color.withOpacity(0.72),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                padding: const EdgeInsets.all(20.0),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width > MediaQuery.of(context).size.height &&
                      sizingInformation.isMobile ? 220 : 420,
                  maxHeight: MediaQuery.of(context).size.width > MediaQuery.of(context).size.height &&
                      sizingInformation.isMobile ? 220 : 420,
                ),
                child: Image.asset(
                  img,
                  fit: BoxFit.fitHeight,
                  color: Theme.of(context).textTheme.headline1.color.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
