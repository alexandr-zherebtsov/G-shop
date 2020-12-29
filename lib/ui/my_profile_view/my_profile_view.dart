import 'package:flutter/material.dart';
import 'package:g_shop/constants/colors.dart';
import 'package:g_shop/core/base/custom_view_model_builder.dart';
import 'package:g_shop/ui/my_profile_view/my_profile_viewmodel.dart';
import 'package:g_shop/ui/utils/other_utils.dart';
import 'package:g_shop/ui/utils/progress_screen.dart';
import 'package:g_shop/ui/utils/scroll_custom.dart';
import 'package:g_shop/ui/widgets/custom_button_widget.dart';
import 'package:g_shop/ui/widgets/headline_widget.dart';
import 'package:g_shop/ui/widgets/profile_text_widget.dart';
import 'package:stacked_themes/stacked_themes.dart';

class MyProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilderConnect<MyProfileViewModel>.reactive(
      viewModelBuilder: () => MyProfileViewModel(),
      builder: (context, model, _) => model.isBusy? ProgressScreen(): Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => model.back(),
            tooltip: 'Back',
          ),
          title: Text('Your Profile', style: Theme.of(context).textTheme.headline2),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.assignment_outlined),
              onPressed: () => model.myAdvert(),
              tooltip: 'Your Adverts',
            ),
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => model.profileEditing(),
              tooltip: 'Edit Profile',
            ),
          ],
        ),
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                        focusColor: transparentColor,
                        hoverColor: transparentColor,
                        splashColor: transparentColor,
                        highlightColor: transparentColor,
                        onTap: () => print('Change Avatar'),
                        child: SizedBox(
                          height: 128,
                          width: 128,
                          child: Stack(
                            children: [
                              ClipOval(
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).brightness == Brightness.light ? blackColor.withOpacity(0.12) : whiteColor.withOpacity(0.2),
                                  ),
                                  child: model.user.photo.isEmpty ? Icon(Icons.person, size: 90) : Image.network(
                                    model.user.photo,
                                    key: UniqueKey(),
                                    loadingBuilder: (BuildContext context, Widget child,
                                        ImageChunkEvent loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress.expectedTotalBytes != null
                                              ? loadingProgress.cumulativeBytesLoaded /
                                              loadingProgress.expectedTotalBytes
                                              : null,
                                        ),
                                      );
                                    },
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, _, error) => Icon(Icons.error_outline, size: 90),
                                  ),
                                ),
                              ),
                              Positioned(
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    child: Center(
                                      child: Icon(
                                        Icons.add,
                                        size: 30,
                                        color: Theme.of(context).iconTheme.color,
                                      ),
                                    ),
                                    decoration: const BoxDecoration(
                                      color: lightGreen,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      SizedBox(
                        height: 128,
                        width: MediaQuery.of(context).size.width - 167,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            model.user.name.isEmpty && model.user.surname.isEmpty ? Offstage() :
                            HeadlineWidget('${model.user.name} ${model.user.surname}', Theme.of(context).textTheme.headline1),
                            model.user.city.isEmpty ? Offstage() : HeadlineWidget(model.user.city, Theme.of(context).textTheme.headline3),
                            Offstage(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  model.user.email.isEmpty ? Offstage() : ProfileTextWidget('Email:', model.user.email),
                  model.user.phoneNumber.isEmpty ? Offstage() : ProfileTextWidget('Phone Number:', formatMaskedPhone(model.user.phoneNumber)),
                  model.user.aboutYourself.isEmpty ? Offstage() : ProfileTextWidget('About Yourself:', model.user.aboutYourself),
                  InkWell(
                    focusColor: transparentColor,
                    hoverColor: transparentColor,
                    splashColor: transparentColor,
                    highlightColor: transparentColor,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).brightness == Brightness.light ? lightGreen :
                            whiteColor.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Theme.of(context).brightness == Brightness.light ? Icons.brightness_2 :
                            Icons.wb_sunny,
                            size: 24,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                        Text('Change Theme', style: Theme.of(context).textTheme.headline3),
                      ],
                    ),
                    onTap: () => getThemeManager(context).selectThemeAtIndex(Theme.of(context).brightness == Brightness.light ? 0 : 1),
                  ),
                  SizedBox(height: 50),
                  Center(child: CustomButtonWidget('Log Out', () => model.logOut())),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
