import 'package:flutter/material.dart';
import 'package:g_shop/constants/localization.dart';
import 'package:g_shop/constants/reg_exp.dart';
import 'package:g_shop/core/base/custom_view_model_builder.dart';
import 'package:g_shop/ui/register_view/register_viewmodel.dart';
import 'package:g_shop/ui/utils/scroll_custom.dart';
import 'package:g_shop/ui/widgets/custom_button_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';

class RegisterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilderConnect<RegisterViewModel>.reactive(
      viewModelBuilder: () => RegisterViewModel(),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            tooltip: textBack,
            onPressed: () => model.back(),
          ),
          title: Text(
            textRegistration,
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: ResponsiveBuilder(
              builder: (context, sizingInformation) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
                child: Form(
                  key: model.registerFormKey,
                  child: Center(
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 500),
                      child: Column(
                        children: [
                          sizingInformation.isTablet || sizingInformation.isDesktop ?
                          SizedBox(height: 80) : Offstage(),
                          TextFormField(
                            controller: model.emailController,
                            cursorColor: Theme.of(context).accentColor,
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            autofocus: false,
                            decoration: const InputDecoration(
                              icon: const Icon(Icons.email),
                              labelText: textEmail,
                            ),
                            validator: (v) {
                              RegExp regex = RegExp(emailReg);
                              if (v.isEmpty) {
                                return textNotBeEmpty;
                              } else if (!regex.hasMatch(v)) {
                                return textCheckYourEmail;
                              } else {
                                return null;
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 60),
                            child: TextFormField(
                              controller: model.passwordController,
                              cursorColor: Theme.of(context).accentColor,
                              keyboardType: TextInputType.text,
                              autocorrect: false,
                              obscureText: true,
                              autofocus: false,
                              decoration: const InputDecoration(
                                icon: const Icon(Icons.lock),
                                labelText: textPassword,
                              ),
                              validator: (v) {
                                if (v.isEmpty) {
                                  return textNotBeEmpty;
                                } else if (v.length < 4) {
                                  return text4Characters;
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          sizingInformation.isTablet || sizingInformation.isDesktop ?
                          SizedBox(height: 100) : Offstage(),
                          CustomButton(
                            textContinue,
                            () {
                              if (model.registerFormKey.currentState.validate()) {
                                model.registerEmailPassword();
                              }
                            },
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
