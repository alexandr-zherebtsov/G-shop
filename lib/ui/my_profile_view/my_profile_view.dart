import 'package:flutter/material.dart';
import 'package:g_shop/constants/colors.dart';
import 'package:g_shop/core/base/custom_view_model_builder.dart';
import 'package:g_shop/ui/my_profile_view/my_profile_viewmodel.dart';
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
      builder: (context, model, _) => Scaffold(
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
                      SizedBox(
                        height: 128,
                        width: 128,
                        child: InkWell(
                          focusColor: transparentColor,
                          hoverColor: transparentColor,
                          splashColor: transparentColor,
                          highlightColor: transparentColor,
                          onTap: () => print('Change Avatar'),
                          child: CircleAvatar(
                            backgroundColor: blackColor.withOpacity(0.1),
                            backgroundImage: AssetImage('assets/images/main_icon.jpg'),
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
                            HeadlineWidget('Alexandr Zherebtsov', Theme.of(context).textTheme.headline1),
                            HeadlineWidget('Vinnytsia', Theme.of(context).textTheme.headline3),
                            Offstage(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  ProfileTextWidget('Email:', 'zherebtsov.o@donnu.edu.ua'),
                  ProfileTextWidget('Phone Number:', '+380111111111'),
                  ProfileTextWidget('About Yourself:', 'Guitarist from Vinnytsia'),
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
