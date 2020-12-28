import 'package:flutter/material.dart';
import 'package:g_shop/constants/colors.dart';
import 'package:g_shop/core/base/custom_view_model_builder.dart';
import 'package:g_shop/ui/advert_editing_view/advert_editing_viewmodel.dart';
import 'package:g_shop/ui/utils/alert_widget.dart';
import 'package:g_shop/ui/utils/scroll_custom.dart';
import 'package:g_shop/ui/widgets/custom_button_widget.dart';

class AdvertEditingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilderConnect<AdvertEditingViewModel>.reactive(
      viewModelBuilder: () => AdvertEditingViewModel(),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            tooltip: 'Back',
            onPressed: () => model.back(),
          ),
          title: Text('Advert Editing', style: Theme.of(context).textTheme.headline2),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete_outline_outlined),
              onPressed: () {
                showAlert(
                  context,
                  'Delete Advert?',
                  'Do you really want to delete this advert? It cannot be restored!',
                   () => print('Delete Advert'),
                );
              },
              tooltip: 'Delete Advert',
            ),
          ],
        ),
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: model.headlineController,
                    cursorColor: Theme.of(context).accentColor,
                    maxLength: 100,
                    decoration: const InputDecoration(
                      labelText: 'Headline',
                    ),
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    autofocus: false,
                  ),
                  TextFormField(
                    controller: model.priceController,
                    cursorColor: Theme.of(context).accentColor,
                    maxLength: 7,
                    keyboardType: TextInputType.number,
                    autocorrect: false,
                    autofocus: false,
                    decoration: const InputDecoration(
                      labelText: 'Price',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      'Add Photos',
                      style: Theme.of(context).textTheme.headline3.copyWith(
                        color: Theme.of(context).brightness == Brightness.light ? grayColor_1 :
                        grayColor_2,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Wrap(
                      children: [
                        SizedBox(
                          width: 58,
                          child: MaterialButton(
                            minWidth: 58,
                            height: 58,
                            padding: EdgeInsets.zero,
                            color: lightGreen,
                            child: Center(child: Icon(Icons.add, size: 50, color: whiteColor)),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: TextFormField(
                      controller: model.descriptionController,
                      cursorColor: Theme.of(context).accentColor,
                      maxLength: 1000,
                      keyboardType: TextInputType.number,
                      autocorrect: false,
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        errorText: null,
                        errorStyle: const TextStyle(color: redColor),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: grayColor_2),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: lightGreen),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: redColor),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: lightGreen),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: Center(
                      child: CustomButtonWidget('Done', () => print('Done')),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
