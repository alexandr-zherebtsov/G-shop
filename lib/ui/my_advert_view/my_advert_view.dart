import 'package:flutter/material.dart';
import 'package:g_shop/core/base/custom_view_model_builder.dart';
import 'package:g_shop/ui/my_advert_view/my_advert_viewmodel.dart';
import 'package:g_shop/ui/utils/scroll_custom.dart';
import 'package:g_shop/ui/widgets/card_widget.dart';

class MyAdvertView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilderConnect<MyAdvertViewModel>.reactive(
      viewModelBuilder: () => MyAdvertViewModel(),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            tooltip: 'Back',
            onPressed: () => model.back(),
          ),
          title: Text('Your Adverts', style: Theme.of(context).textTheme.headline2),
        ),
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
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

