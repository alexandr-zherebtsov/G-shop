import 'package:flutter/material.dart';
import 'package:g_shop/core/base/custom_view_model_builder.dart';
import 'package:g_shop/ui/home_view/home_viewmodel.dart';
import 'package:g_shop/ui/utils/scroll_custom.dart';
import 'package:g_shop/ui/widgets/card_widget.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilderConnect<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          title: Text('Home', style: Theme.of(context).textTheme.headline2),
          leading: null,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () => model.myProfile(),
              tooltip: 'Your Profile',
            ),
          ],
        ),
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: CardWidget(
              1,
              'assets/images/guitar.jpg',
              'Gibson Les Paul',
              textBody,
              '1000',
              () => model.advert(),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: 'buttonCreateAdvert',
          backgroundColor: Theme.of(context).buttonColor,
          tooltip: 'Create Advert',
          child: Icon(
            Icons.add,
            color: Theme.of(context).iconTheme.color,
            size: 40,
          ),
          onPressed: () => model.advertCreate(),
        ),
      ),
    );
  }
}

const String textBody = 'The Gibson Les Paul is a solid body electric guitar that was first sold by the Gibson Guitar Corporation in 1952. The Les Paul was designed by Gibson president Ted McCarty, factory manager John Huis and their team with input from and endorsement by guitarist Les Paul. Its typical design features a solid mahogany body with a carved maple top and a single cutaway, a mahogany set-in neck with a rosewood fretboard, two pickups with independent volume and tone controls, and a stoptail bridge, although variants exist.';
