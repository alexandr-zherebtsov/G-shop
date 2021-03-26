import 'package:flutter/material.dart';
import 'package:g_shop/constants/localization.dart';
import 'package:g_shop/constants/reg_exp.dart';
import 'package:g_shop/constants/strings.dart';
import 'package:g_shop/core/base/custom_view_model_builder.dart';
import 'package:g_shop/ui/register_view/register_viewmodel.dart';
import 'package:g_shop/ui/utils/alert_widget.dart';
import 'package:g_shop/ui/utils/other_utils.dart';
import 'package:g_shop/ui/utils/scroll_custom.dart';
import 'package:g_shop/ui/widgets/custom_button_widget.dart';
import 'package:g_shop/ui/widgets/headline_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';

class RegisterDataView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilderConnect<RegisterViewModel>.reactive(
      viewModelBuilder: () => RegisterViewModel(),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          leading: null,
          title: Text(textRegistration, style: Theme.of(context).textTheme.headline2),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: () => showPasswordAlert(
                context,
                textDeleteAccount + markQuestion,
                textDescriptionDeleteAccount,
                () => model.deleteUser(model.getEmail()),
                model.deletePasswordController,
                model.deleteFormKey,
              ),
              tooltip: textCancelRegistration,
            ),
          ],
        ),
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: ResponsiveBuilder(
              builder: (context, sizingInformation) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Form(
                  key: model.registerDataFormKey,
                  child: Center(
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 500),
                      child: Column(
                        children: [
                          sizingInformation.isTablet || sizingInformation.isDesktop ?
                          SizedBox(height: 30) : Offstage(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: HeadlineWidget(
                              model.getEmail(),
                              Theme.of(context).textTheme.headline1,
                            ),
                          ),
                          TextFormField(
                            controller: model.nameController,
                            cursorColor: Theme.of(context).accentColor,
                            maxLength: 40,
                            keyboardType: TextInputType.text,
                            autocorrect: false,
                            autofocus: false,
                            decoration: const InputDecoration(
                              counter: Offstage(),
                              labelText: textName,
                            ),
                            validator: (v) {
                              if (v.isEmpty) {
                                return textNotBeEmpty;
                              } else {
                                return null;
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: TextFormField(
                              controller: model.surnameController,
                              cursorColor: Theme.of(context).accentColor,
                              keyboardType: TextInputType.text,
                              maxLength: 40,
                              autofocus: false,
                              autocorrect: false,
                              decoration: const InputDecoration(
                                counter: Offstage(),
                                labelText: textSurname,
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
                          TextFormField(
                            controller: model.cityController,
                            cursorColor: Theme.of(context).accentColor,
                            keyboardType: TextInputType.text,
                            autocorrect: false,
                            autofocus: false,
                            maxLength: 50,
                            decoration: const InputDecoration(
                              counter: Offstage(),
                              labelText: textCity,
                            ),
                            validator: (v) {
                              if (v.isEmpty) {
                                return textNotBeEmpty;
                              } else {
                                return null;
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: TextFormField(
                              controller: model.phoneNumberController,
                              cursorColor: Theme.of(context).accentColor,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [maskFormatter],
                              autocorrect: false,
                              autofocus: false,
                              decoration: const InputDecoration(
                                labelText: textPhoneNumber,
                              ),
                              validator: (v) {
                                RegExp regex = RegExp(phoneReg);
                                if (v.isEmpty) {
                                  return textNotBeEmpty;
                                } else if (dropFormatMaskedPhone(v).length < 12 || !regex.hasMatch(dropFormatMaskedPhone(v))) {
                                  return textCheckYourPhone;
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          sizingInformation.isTablet || sizingInformation.isDesktop ?
                          SizedBox(height: 50) : Offstage(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: CustomButton(
                              textRegister,
                              () {
                                if (model.registerDataFormKey.currentState.validate()) {
                                  model.registerDataEmailPassword();
                                }
                              },
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
