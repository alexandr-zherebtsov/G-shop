import 'package:flutter/material.dart';
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
          title: Text('Registration',
              style: Theme.of(context).textTheme.headline2),
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
                      autofocus: false,
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.email),
                        labelText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 60),
                      child: TextFormField(
                        controller: model.passwordController,
                        cursorColor: Theme.of(context).accentColor,
                        autofocus: false,
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.lock),
                          labelText: 'Password',
                        ),
                        keyboardType: TextInputType.text,
                        autocorrect: false,
                        obscureText: true,
                      ),
                    ),
                    CustomButtonWidget(
                      'Continue',
                      () {
                        model.registerEmailPassword();
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
