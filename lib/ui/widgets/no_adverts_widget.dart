import 'package:flutter/material.dart';
import 'package:g_shop/ui/widgets/headline_widget.dart';

class NoAdvertsWidget extends StatelessWidget {
  final String title;
  const NoAdvertsWidget({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
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
              maxWidth: 420,
              maxHeight: 420,
            ),
            child: Image.asset(
              'assets/icons/guitar_vector.png',
              fit: BoxFit.fitHeight,
              color: Theme.of(context).textTheme.headline1.color.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}
