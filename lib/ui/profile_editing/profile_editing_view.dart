import 'package:flutter/material.dart';
import 'package:g_shop/constants/colors.dart';
import 'package:g_shop/constants/localization.dart';
import 'package:g_shop/constants/reg_exp.dart';
import 'package:g_shop/constants/strings.dart';
import 'package:g_shop/core/base/custom_view_model_builder.dart';
import 'package:g_shop/core/models/user_model.dart';
import 'package:g_shop/ui/profile_editing/profile_editing_viewmodel.dart';
import 'package:g_shop/ui/utils/alert_widget.dart';
import 'package:g_shop/ui/utils/progress_screen.dart';
import 'package:g_shop/ui/utils/scroll_custom.dart';
import 'package:g_shop/ui/widgets/custom_button_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProfileEditingView extends StatelessWidget {
  final UserModel user;
  const ProfileEditingView({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilderConnect<ProfileEditingViewModel>.reactive(
      viewModelBuilder: () => ProfileEditingViewModel(),
      builder: (context, model, _) => model.isBusy ? ProgressScreen() : Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            tooltip: textBack,
            onPressed: () => model.back(),
          ),
          title: Text(textProfileEditing, style: Theme.of(context).textTheme.headline2),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete_outline_outlined),
              onPressed: () => showPasswordAlert(
                context,
                textDeleteAccount + markQuestion,
                textDescriptionDeleteAccount,
                () => model.deleteUser(user),
                model.deletePasswordController,
                model.deleteFormKey,
              ),
              tooltip: textDeleteAccount,
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
                          controller: model.nameController..text = user.name,
                          cursorColor: Theme.of(context).accentColor,
                          maxLength: 35,
                          autofocus: false,
                          decoration: const InputDecoration(
                            labelText: textName,
                          ),
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                        ),
                        TextFormField(
                          controller: model.surnameController..text = user.surname,
                          cursorColor: Theme.of(context).accentColor,
                          maxLength: 35,
                          autofocus: false,
                          decoration: const InputDecoration(
                            labelText: textSurname,
                          ),
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                        ),
                        TextFormField(
                          controller: model.cityController..text = user.city,
                          cursorColor: Theme.of(context).accentColor,
                          maxLength: 50,
                          autofocus: false,
                          decoration: const InputDecoration(
                            labelText: textCity,
                          ),
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                        ),
                        TextFormField(
                          controller: model.emailController..text = user.email,
                          cursorColor: Theme.of(context).accentColor,
                          maxLength: 50,
                          enabled: false,
                          autofocus: false,
                          decoration: const InputDecoration(
                            labelText: textEmail,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                        ),
                        TextFormField(
                          controller: model.phoneNumberController..text = user.phoneNumber,
                          cursorColor: Theme.of(context).accentColor,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [maskFormatter],
                          autofocus: false,
                          decoration: const InputDecoration(
                            labelText: textPhoneNumber,
                          ),
                          autocorrect: false,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40.0),
                          child: TextFormField(
                            controller: model.aboutYourselfController..text = user.aboutYourself,
                            cursorColor: Theme.of(context).accentColor,
                            maxLength: 500,
                            keyboardType: TextInputType.text,
                            autocorrect: false,
                            autofocus: false,
                            minLines: 1,
                            maxLines: 15,
                            decoration: InputDecoration(
                              labelText: textAboutYourself,
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
                        Center(
                          child: CustomButton(textSave, () => model.editUser(user)),
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
