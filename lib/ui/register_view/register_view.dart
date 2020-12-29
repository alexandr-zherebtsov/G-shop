import 'package:flutter/material.dart';
import 'package:g_shop/constants/reg_exp.dart';
import 'package:g_shop/core/base/custom_view_model_builder.dart';
import 'package:g_shop/ui/register_view/register_viewmodel.dart';
import 'package:g_shop/ui/utils/scroll_custom.dart';
import 'package:g_shop/ui/widgets/custom_button_widget.dart';

class RegisterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilderConnect<RegisterViewModel>.reactive(
      viewModelBuilder: () => RegisterViewModel(),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            tooltip: 'Back',
            onPressed: () => model.back(),
          ),
          title: Text(
            'Registration',
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
              child: Form(
                key: model.registerFormKey,
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
                        cursorColor: Theme.of(context).accentColor,
                        keyboardType: TextInputType.text,
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
                      'Continue',
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
    );
  }
}
