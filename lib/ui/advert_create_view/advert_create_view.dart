import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g_shop/constants/colors.dart';
import 'package:g_shop/constants/localization.dart';
import 'package:g_shop/constants/reg_exp.dart';
import 'package:g_shop/core/base/custom_view_model_builder.dart';
import 'package:g_shop/ui/advert_create_view/advert_create_viewmodel.dart';
import 'package:g_shop/ui/utils/scroll_custom.dart';
import 'package:g_shop/ui/widgets/custom_button_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AdvertCreateView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilderConnect<AdvertCreateViewModel>.reactive(
      viewModelBuilder: () => AdvertCreateViewModel(),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            tooltip: textBack,
            onPressed: () => model.back(),
          ),
          title: Text(textCreateAdvert, style: Theme.of(context).textTheme.headline2),
        ),
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: ResponsiveBuilder(
              builder: (context, sizingInformation) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                child: Form(
                  key: model.createAdvertDataFormKey,
                  child: Center(
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 500),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          sizingInformation.isTablet || sizingInformation.isDesktop ? SizedBox(height: 30) : Offstage(),
                          TextFormField(
                            controller: model.headlineController,
                            cursorColor: Theme.of(context).accentColor,
                            keyboardType: TextInputType.text,
                            autocorrect: false,
                            autofocus: false,
                            maxLength: 100,
                            decoration: const InputDecoration(labelText: textHeadline),
                            validator: (v) {
                              if (v.isEmpty) {
                                return textNotBeEmpty;
                              } else {
                                return null;
                              }
                            },
                          ),
                          TextFormField(
                            controller: model.priceController,
                            cursorColor: Theme.of(context).accentColor,
                            keyboardType: TextInputType.number,
                            autocorrect: false,
                            autofocus: false,
                            maxLength: 7,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(numberReg))],
                            decoration: const InputDecoration(labelText: textPrice),
                            validator: (v) {
                              if (v.isEmpty) {
                                return textNotBeEmpty;
                              } else {
                                return null;
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text(
                              textAddPhotos,
                              style: Theme.of(context).textTheme.headline3.copyWith(
                                color: Theme.of(context).brightness == Brightness.light ? grayColor_1 : grayColor_2,
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
                                    child: Center(
                                      child: Icon(
                                        Icons.add,
                                        size: 50,
                                        color: Theme.of(context).iconTheme.color,
                                      ),
                                    ),
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
                              keyboardType: TextInputType.text,
                              autocorrect: false,
                              autofocus: false,
                              minLines: 1,
                              maxLines: 15,
                              decoration: InputDecoration(
                                labelText: textDescription,
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
                              validator: (v) {
                                if (v.isEmpty) {
                                  return textNotBeEmpty;
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          sizingInformation.isTablet || sizingInformation.isDesktop ? SizedBox(height: 50) : Offstage(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30.0),
                            child: Center(
                              child: CustomButtonWidget(
                                textCreate,
                                () {
                                  if (model.createAdvertDataFormKey.currentState.validate()) {
                                    model.createAdvertData();
                                  }
                                },
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
          ),
        ),
      ),
    );
  }
}
