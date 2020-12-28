import 'package:flutter/material.dart';
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
              child: Text('Registration', style: Theme.of(context).textTheme.headline3),
              onPressed: () => model.goToRegister(),
            ),
          ],
        ),
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
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
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.lock),
                        labelText: 'Password',
                      ),
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                      obscureText: true,
                      autofocus: false,
                    ),
                  ),
                  CustomButtonWidget(
                    'Log In',
                    () {
                      model.signInEmailPassword();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
