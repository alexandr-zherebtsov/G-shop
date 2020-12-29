import 'package:flutter/material.dart';
import 'package:g_shop/constants/colors.dart';
import 'package:g_shop/constants/reg_exp.dart';
import 'package:g_shop/core/base/custom_view_model_builder.dart';
import 'package:g_shop/ui/login_view/login_viewmodel.dart';
import 'package:g_shop/ui/utils/scroll_custom.dart';
import 'package:g_shop/ui/widgets/custom_button_widget.dart';

class LogInView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilderConnect<LogInViewModel>.reactive(
      viewModelBuilder: () => LogInViewModel(),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          leading: null,
          title: Text('Log In', style: Theme.of(context).textTheme.headline2),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Registration',
                style: Theme.of(context).textTheme.headline3.copyWith(color: whiteColor),
              ),
              onPressed: () => model.goToRegister(),
            ),
          ],
        ),
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
              child: Form(
                key: model.loginFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: model.emailController,
                      cursorColor: Theme.of(context).accentColor,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      autofocus: false,
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.email),
                        labelText: 'Email',
                      ),
                      validator: (v) {
                        RegExp regex = RegExp(emailReg);
                        if (v.isEmpty) {
                          return 'Not be empty';
                        } else if (!regex.hasMatch(v)) {
                          return 'Check your email';
                        } else {
                          return null;
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 60),
                      child: TextFormField(
                        controller: model.passwordController,
                        keyboardType: TextInputType.text,
                        cursorColor: Theme.of(context).accentColor,
                        autocorrect: false,
                        obscureText: true,
                        autofocus: false,
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.lock),
                          labelText: 'Password',
                        ),
                        validator: (v) {
                          if (v.isEmpty) {
                            return 'Not be empty';
                          } else if (v.length < 4) {
                            return 'At least 4 characters';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    CustomButtonWidget(
                      'Log In',
                      () {
                        if (model.loginFormKey.currentState.validate()) {
                          model.signInEmailPassword();
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
    );
  }
}
