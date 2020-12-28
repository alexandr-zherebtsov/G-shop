import 'package:flutter/material.dart';
import 'package:g_shop/core/base/custom_view_model_builder.dart';
import 'package:g_shop/ui/register_view/register_viewmodel.dart';
import 'package:g_shop/ui/utils/scroll_custom.dart';
import 'package:g_shop/ui/widgets/custom_button_widget.dart';

class RegisterDataView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilderConnect<RegisterViewModel>.reactive(
      viewModelBuilder: () => RegisterViewModel(),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          leading: null,
          title: Text('Registration', style: Theme.of(context).textTheme.headline2),
        ),
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Column(
                children: [
                  TextFormField(
                    controller: model.nameController,
                    cursorColor: Theme.of(context).accentColor,
                    maxLength: 35,
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    autofocus: false,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: TextFormField(
                      controller: model.surnameController,
                      cursorColor: Theme.of(context).accentColor,
                      keyboardType: TextInputType.text,
                      maxLength: 35,
                      autofocus: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        labelText: 'Surname',
                      ),
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
                      labelText: 'City',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: TextFormField(
                      controller: model.phoneNumberController,
                      cursorColor: Theme.of(context).accentColor,
                      keyboardType: TextInputType.phone,
                      autocorrect: false,
                      autofocus: false,
                      maxLength: 13,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: CustomButtonWidget('Register', () => model.registerDataEmailPassword()),
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
