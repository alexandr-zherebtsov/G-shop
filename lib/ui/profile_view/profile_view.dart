import 'package:flutter/material.dart';
import 'package:g_shop/constants/colors.dart';
import 'package:g_shop/constants/localization.dart';
import 'package:g_shop/constants/strings.dart';
import 'package:g_shop/core/base/custom_view_model_builder.dart';
import 'package:g_shop/ui/profile_view/profile_viewmodel.dart';
import 'package:g_shop/ui/utils/alert_widget.dart';
import 'package:g_shop/ui/utils/other_utils.dart';
import 'package:g_shop/ui/utils/profile_image.dart';
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
      builder: (context, model, _) => model.isBusy ? ProgressScreen() : ResponsiveBuilder(
        builder: (context, sizingInformation) => Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: model.currentUserUid == uid ? null : IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => goBackNav(),
              tooltip: textBack,
            ),
            title: Text(
              model.currentUserUid == uid ? textYourProfile : textProfile,
              style: Theme.of(context).textTheme.headline2,
            ),
            actions: model.currentUserUid == uid ? <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => model.toProfileEditing(user: model.user),
                tooltip: textEditProfile,
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
                          focusColor: colorTransparent,
                          hoverColor: colorTransparent,
                          splashColor: colorTransparent,
                          highlightColor: colorTransparent,
                          onTap: () => model.buildBottomSheet(context, model.user),
                          child: SizedBox(
                            height: sizingInformation.isTablet || sizingInformation.isDesktop ? 300 : 128,
                            width: sizingInformation.isTablet || sizingInformation.isDesktop ? 300 : 128,
                            child: Stack(
                              children: [
                                buildProfileImage(context, sizingInformation, model.user.photo),
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
                                        color: colorLightGreen,
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
                            child: buildProfileImage(context, sizingInformation, model.user.photo),
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
                    model.user.email.isEmpty ? Offstage() : ProfileTextWidget(textEmail + markColon, model.user.email),
                    model.user.phoneNumber.isEmpty ? Offstage() : ProfileTextWidget(textPhoneNumber + markColon, formatMaskedPhone(model.user.phoneNumber)),
                    model.user.aboutYourself.isEmpty ? Offstage() : ProfileTextWidget(model.currentUserUid == uid ? textAboutYourself : textAboutPerson + markColon, model.user.aboutYourself),
                    model.currentUserUid == uid ? InkWell(
                      focusColor: colorTransparent,
                      hoverColor: colorTransparent,
                      splashColor: colorTransparent,
                      highlightColor: colorTransparent,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            margin: const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              color: Theme.of(context).brightness == Brightness.light ? colorLightGreen :
                              colorWhite.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Theme.of(context).brightness == Brightness.light ? Icons.brightness_2 :
                              Icons.wb_sunny,
                              size: 24,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ),
                          Text(textChangeTheme, style: Theme.of(context).textTheme.headline3),
                        ],
                      ),
                      onTap: () => getThemeManager(context).selectThemeAtIndex(Theme.of(context).brightness == Brightness.light ? 0 : 1),
                    ) : Offstage(),
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0, bottom: 26.0),
                      child: Center(
                        child: CustomButton(
                          model.currentUserUid == uid ? textLogOut : textCall,
                          model.currentUserUid == uid ? () =>
                          showAlert(
                            context,
                            textLogOut + markQuestion,
                            textLogOutMessage + markQuestion,
                            () => model.logOut(),
                            isLogOut: true,
                          ) : () => model.numFun(model.user.phoneNumber),
                        ),
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
