import 'package:flutter/material.dart';
import 'package:g_shop/constants/colors.dart';
import 'package:g_shop/core/base/custom_view_model_builder.dart';
import 'package:g_shop/ui/profile_editing/profile_editing_viewmodel.dart';
import 'package:g_shop/ui/utils/alert_widget.dart';
import 'package:g_shop/ui/utils/scroll_custom.dart';
import 'package:g_shop/ui/widgets/custom_button_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProfileEditingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilderConnect<ProfileEditingViewModel>.reactive(
      viewModelBuilder: () => ProfileEditingViewModel(),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            tooltip: 'Back',
            onPressed: () => model.back(),
          ),
          title: Text('Profile Editing', style: Theme.of(context).textTheme.headline2),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete_outline_outlined),
              onPressed: () {
                showAlert(
                  context,
                  'Delete Account?',
                  'Do you really want to delete this acсount? It cannot be restored!',
                   () => print('Delete Account'),
                );
              },
              tooltip: 'Delete Account',
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
                      children: [
                        sizingInformation.isTablet || sizingInformation.isDesktop ?
                        SizedBox(height: 30) : Offstage(),
                        TextFormField(
                          controller: model.nameController,
                          cursorColor: Theme.of(context).accentColor,
                          maxLength: 35,
                          autofocus: false,
                          decoration: const InputDecoration(
                            labelText: 'Name',
                          ),
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                        ),
                        TextFormField(
                          controller: model.surnameController,
                          cursorColor: Theme.of(context).accentColor,
                          maxLength: 35,
                          autofocus: false,
                          decoration: const InputDecoration(
                            labelText: 'Surname',
                          ),
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                        ),
                        TextFormField(
                          controller: model.cityController,
                          cursorColor: Theme.of(context).accentColor,
                          maxLength: 50,
                          autofocus: false,
                          decoration: const InputDecoration(
                            labelText: 'City',
                          ),
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                        ),
                        TextFormField(
                          controller: model.emailController,
                          cursorColor: Theme.of(context).accentColor,
                          maxLength: 50,
                          autofocus: false,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                        ),
                        TextFormField(
                          controller: model.phoneNumberController,
                          cursorColor: Theme.of(context).accentColor,
                          maxLength: 13,
                          autofocus: false,
                          decoration: const InputDecoration(
                            labelText: 'Phone Number',
                          ),
                          keyboardType: TextInputType.phone,
                          autocorrect: false,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40.0),
                          child: TextFormField(
                            controller: model.aboutYourselfController,
                            cursorColor: Theme.of(context).accentColor,
                            maxLength: 500,
                            keyboardType: TextInputType.text,
                            autocorrect: false,
                            autofocus: false,
                            minLines: 1,
                            maxLines: 15,
                            decoration: InputDecoration(
                              labelText: 'About Yourself',
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
                        sizingInformation.isTablet || sizingInformation.isDesktop ?
                        SizedBox(height: 50) : Offstage(),
                        Center(
                          child: CustomButtonWidget('Save', () => print('Save')),
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
    );
  }
}
