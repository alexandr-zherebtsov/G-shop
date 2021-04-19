import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:g_shop/constants/colors.dart';
import 'package:responsive_builder/responsive_builder.dart';

Widget buildProfileImage(BuildContext context, SizingInformation sizingInformation, String photo) {
  return ClipOval(
    child: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light ? colorBlack.withOpacity(0.12) : colorWhite.withOpacity(0.2),
      ),
      child: photo.isEmpty ? Icon(
        Icons.person,
        size: sizingInformation.isTablet || sizingInformation.isDesktop ? 210 : 90,
      ) : CachedNetworkImage(
        imageUrl: photo,
        key: UniqueKey(),
        progressIndicatorBuilder: (BuildContext context, _, DownloadProgress loadingProgress) {
          if (loadingProgress == null) return Offstage();
          return Center(child: CircularProgressIndicator());
        },
        fit: BoxFit.cover,
        errorWidget: (context, _, error) => Icon(
          Icons.error_outline,
          size: sizingInformation.isTablet || sizingInformation.isDesktop ? 190 : 70,
        ),
      ),
    ),
  );
}