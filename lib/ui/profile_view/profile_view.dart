import 'package:flutter/material.dart';
import 'package:g_shop/constants/colors.dart';
import 'package:g_shop/core/base/custom_view_model_builder.dart';
import 'package:g_shop/ui/profile_view/profile_viewmodel.dart';
import 'package:g_shop/ui/utils/other_utils.dart';
import 'package:g_shop/ui/utils/progress_screen.dart';
import 'package:g_shop/ui/utils/scroll_custom.dart';
import 'package:g_shop/ui/widgets/custom_button_widget.dart';
import 'package:g_shop/ui/widgets/headline_widget.dart';
import 'package:g_shop/ui/widgets/profile_text_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked_themes/stacked_themes.dart';

class ProfileView extends StatelessWidget {
  final String uid;
  const ProfileView({Key key, this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilderConnect<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      onModelReady: (vm) => vm.initUser(uid),
      builder: (context, model, _) => model.isBusy? ProgressScreen() : model.isBusy ? ProgressScreen() : ResponsiveBuilder(
        builder: (context, sizingInformation) => Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => model.back(),
              tooltip: 'Back',
            ),
            title: Text(
              model.currentUserUid == uid ? 'Your Profile' : 'Profile',
              style: Theme.of(context).textTheme.headline2,
            ),
            actions: model.currentUserUid == uid ? <Widget>[
              IconButton(
                icon: Icon(Icons.assignment_outlined),
                onPressed: () => model.toMyAdverts(),
                tooltip: 'Your Adverts',
              ),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => model.toProfileEditing(),
                tooltip: 'Edit Profile',
              ),
            ] : null,
          ),
          body: ScrollConfiguration(
            behavior: MyBehavior(),
            child: SingleChildScrollView(
              child: Padding(
                padding: sizingInformation.isMobile && MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ?
                const EdgeInsets.symmetric(horizontal: 26, vertical: 10) : sizingInformation.isTablet || sizingInformation.isDesktop ?
                const EdgeInsets.all(40) : const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        model.currentUserUid == uid ? InkWell(
                          focusColor: transparentColor,
                          hoverColor: transparentColor,
                          splashColor: transparentColor,
                          highlightColor: transparentColor,
                          onTap: () => print('Change Avatar'),
                          child: SizedBox(
                            height: sizingInformation.isTablet || sizingInformation.isDesktop ? 300 : 128,
                            width: sizingInformation.isTablet || sizingInformation.isDesktop ? 300 : 128,
                            child: Stack(
                              children: [
                                ClipOval(
                                  child: Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).brightness == Brightness.light ? blackColor.withOpacity(0.12) : whiteColor.withOpacity(0.2),
                                    ),
                                    child: model.user.photo.isEmpty ? Icon(
                                      Icons.person,
                                      size: sizingInformation.isTablet || sizingInformation.isDesktop ? 210 : 90,
                                    ) : Image.network(
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
                                      errorBuilder: (context, _, error) => Icon(
                                        Icons.error_outline,
                                        size: sizingInformation.isTablet || sizingInformation.isDesktop ? 210 : 90,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      width: sizingInformation.isTablet || sizingInformation.isDesktop ? 60 : 30,
                                      height: sizingInformation.isTablet || sizingInformation.isDesktop ? 60 : 30,
                                      child: Center(
                                        child: Icon(
                                          Icons.add,
                                          size: sizingInformation.isTablet || sizingInformation.isDesktop ? 60 : 30,
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
                        ) : SizedBox(
                          height: sizingInformation.isTablet || sizingInformation.isDesktop ? 300 : 128,
                          width: sizingInformation.isTablet || sizingInformation.isDesktop ? 300 : 128,
                          child: ClipOval(
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: Theme.of(context).brightness == Brightness.light ? blackColor.withOpacity(0.12) : whiteColor.withOpacity(0.2),
                              ),
                              child: model.user.photo.isEmpty ? Icon(
                                Icons.person,
                                size: sizingInformation.isTablet || sizingInformation.isDesktop ? 210 : 90,
                              ) : Image.network(
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
                                errorBuilder: (context, _, error) => Icon(
                                  Icons.error_outline,
                                  size: sizingInformation.isTablet || sizingInformation.isDesktop ? 210 : 90,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        SizedBox(
                          height: sizingInformation.isTablet || sizingInformation.isDesktop ? 280 : 128,
                          width: sizingInformation.isMobile && MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ?
                          MediaQuery.of(context).size.width - 195 :
                          sizingInformation.isTablet || sizingInformation.isDesktop ?
                          MediaQuery.of(context).size.width - 395 : MediaQuery.of(context).size.width - 167,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              model.user.name.isEmpty && model.user.surname.isEmpty ? Offstage() :
                              HeadlineWidget(
                                model.user.name + ' ' + model.user.surname,
                                sizingInformation.isTablet || sizingInformation.isDesktop ?
                                Theme.of(context).textTheme.headline1.copyWith(fontSize: 44) : Theme.of(context).textTheme.headline1,
                              ),
                              model.user.city.isEmpty ? Offstage() : HeadlineWidget(
                                model.user.city,
                                sizingInformation.isTablet || sizingInformation.isDesktop ?
                                Theme.of(context).textTheme.headline3.copyWith(fontSize: 32) : Theme.of(context).textTheme.headline3,
                              ),
                              Offstage(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: sizingInformation.isTablet || sizingInformation.isDesktop ? 30 : 15,
                    ),
                    model.user.email.isEmpty ? Offstage() : ProfileTextWidget('Email:', model.user.email),
                    model.user.phoneNumber.isEmpty ? Offstage() : ProfileTextWidget('Phone Number:', formatMaskedPhone(model.user.phoneNumber)),
                    model.user.aboutYourself.isEmpty ? Offstage() : ProfileTextWidget('About Yourself:', model.user.aboutYourself),
                    model.currentUserUid == uid ? InkWell(
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
                    ) : Offstage(),
                    SizedBox(height: 50),
                    Center(
                      child: CustomButtonWidget(
                        model.currentUserUid == uid ? 'Log Out' : 'Call',
                        model.currentUserUid == uid ? () => model.logOut() : () => model.numFun(model.user.phoneNumber),
                      ),
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
