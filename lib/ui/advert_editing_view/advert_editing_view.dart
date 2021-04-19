import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g_shop/constants/colors.dart';
import 'package:g_shop/constants/localization.dart';
import 'package:g_shop/constants/reg_exp.dart';
import 'package:g_shop/constants/strings.dart';
import 'package:g_shop/core/base/custom_view_model_builder.dart';
import 'package:g_shop/core/models/advert_model.dart';
import 'package:g_shop/ui/advert_editing_view/advert_editing_viewmodel.dart';
import 'package:g_shop/ui/utils/alert_widget.dart';
import 'package:g_shop/ui/utils/progress_screen.dart';
import 'package:g_shop/ui/utils/scroll_custom.dart';
import 'package:g_shop/ui/widgets/add_images_widget.dart';
import 'package:g_shop/ui/widgets/custom_button_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AdvertEditingView extends StatelessWidget {
  final AdvertModel advert;
  AdvertEditingView({Key key, this.advert});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilderConnect<AdvertEditingViewModel>.reactive(
      viewModelBuilder: () => AdvertEditingViewModel(),
      builder: (context, model, _) => model.isBusy ? ProgressScreen() : Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            tooltip: textBack,
            onPressed: () => model.back(),
          ),
          title: Text(textAdvertEditing, style: Theme.of(context).textTheme.headline2),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete_outline_outlined),
              onPressed: () {
                showAlert(
                  context,
                  textDeleteAdvert + markQuestion,
                  textDescriptionDeleteAdvert,
                  () => model.deleteAdvert(advert),
                );
              },
              tooltip: textDeleteAdvert,
            ),
          ],
        ),
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: ResponsiveBuilder(
              builder: (context, sizingInformation) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                child: Center(
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 500),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sizingInformation.isTablet || sizingInformation.isDesktop ?
                        SizedBox(height: 30) : Offstage(),
                        TextFormField(
                          controller: model.headlineController..text = advert.headline,
                          cursorColor: Theme.of(context).accentColor,
                          maxLength: 100,
                          decoration: const InputDecoration(
                            labelText: textHeadline,
                          ),
                          onChanged: (v) {
                            print(model.headlineController.text);
                          },
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                          autofocus: false,
                        ),
                        TextFormField(
                          controller: model.priceController..text = advert.price.toString(),
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(numberReg))],
                          cursorColor: Theme.of(context).accentColor,
                          maxLength: 7,
                          keyboardType: TextInputType.number,
                          autocorrect: false,
                          autofocus: false,
                          decoration: const InputDecoration(
                            labelText: textPrice,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 6.0),
                                child: SizedBox(
                                  width: 40.0,
                                  height: 40.0,
                                  child: Material(
                                    color: colorTransparent,
                                    clipBehavior: Clip.hardEdge,
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: IconButton(
                                      icon: model.editImages ? Icon(
                                        Icons.close, color: Theme.of(context).textTheme.headline3.color,
                                      ) : Icon(
                                        Icons.edit, color: Theme.of(context).textTheme.headline3.color,
                                      ),
                                      tooltip: model.editImages ? textCancel : textEdit,
                                      onPressed: () {
                                        if(model.editImages) model.cancelEditImages();
                                        model.activateEditImages(advert.images);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                textPhotos,
                                style: Theme.of(context).textTheme.headline3.copyWith(
                                  color: Theme.of(context).brightness == Brightness.light ? colorGray_1 :
                                  colorGray_2,
                                ),
                              ),
                              model.editImages ? Text(
                                '  ' + (model.addedImages.length + model.imagesToEdit.length).toString() + ' / 5',
                                style: Theme.of(context).textTheme.headline3.copyWith(
                                  color: Theme.of(context).brightness == Brightness.light ? colorGray_1 :
                                  colorGray_2,
                                ),
                              ) : Text(
                                '  ' + advert.images.length.toString() + ' / 5',
                                style: Theme.of(context).textTheme.headline3.copyWith(
                                  color: Theme.of(context).brightness == Brightness.light ? colorGray_1 :
                                  colorGray_2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: model.editImages ? Wrap(
                            children:
                            model.imagesToEdit.map((e) => getImageWidget(() => model.deleteImageToEdit(e), false, url: e)).toList()
                            ..addAll(model.addedImages.isEmpty ? [Offstage()] :
                              model.addedImages.map((e) => getPickedImageWidget(e, () => model.deleteImageFileToEdit(e))).toList()
                            )..add(
                              model.imagesToEdit.length + model.addedImages.length < 5 ?
                              AddPhotoButton(() => model.addImageToEdit()) : Offstage(),
                            ),
                          ) : Wrap(
                            children: advert.images.map((e) => imageNetworkWidget(e)).toList(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: TextFormField(
                            controller: model.descriptionController..text = advert.description,
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
                              errorStyle: const TextStyle(color: colorRed),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: colorGray_2),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: colorLightGreen),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: colorRed),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: colorLightGreen),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                        sizingInformation.isTablet || sizingInformation.isDesktop ?
                        SizedBox(height: 50) : Offstage(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30.0),
                          child: Center(
                            child: CustomButton(textDone, () => model.editAdvert(advert)),
                          ),
                        )
                      ],
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
