import 'package:flutter/material.dart';
import 'package:g_shop/constants/colors.dart';
import 'package:g_shop/core/base/custom_view_model_builder.dart';
import 'package:g_shop/ui/profile_view/profile_viewmodel.dart';
import 'package:g_shop/ui/utils/scroll_custom.dart';
import 'package:g_shop/ui/widgets/custom_button_widget.dart';
import 'package:g_shop/ui/widgets/headline_widget.dart';
import 'package:g_shop/ui/widgets/profile_text_widget.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilderConnect<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      builder: (context, model, _) =>  Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            tooltip: 'Back',
            onPressed: () => model.back(),
          ),
          title: Text('Profile', style: Theme.of(context).textTheme.headline2),
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
                        child: CircleAvatar(
                          backgroundColor: blackColor.withOpacity(0.1),
                          backgroundImage: AssetImage('assets/images/main_icon.jpg'),
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
                  ProfileTextWidget('About Person:', 'Guitarist from Vinnytsia'),
                  SizedBox(height: 50),
                  Center(
                    child: CustomButtonWidget(
                      'Call',
                      () => model.numFun('+380111111111'),
                    ),
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
