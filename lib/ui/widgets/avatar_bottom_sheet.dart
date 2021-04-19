import 'package:flutter/material.dart';
import 'package:g_shop/constants/colors.dart';
import 'package:g_shop/constants/localization.dart';

Widget avatarBottomSheet(BuildContext context, String photo, Function change, Function delete) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 14.0, bottom: 8.0),
            child: Text(
              textChangeAvatar,
              style: Theme.of(context).textTheme.headline3.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Divider(height: 1, thickness: 1, color: Theme.of(context).textTheme.headline3.color.withOpacity(0.1)),
          ),
          Material(
            color: colorTransparent,
            child: ListTile(
              onTap: change,
              leading: Icon(Icons.add_a_photo_outlined),
              title: Text(
                textNewAvatar,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
          ),
          photo.isNotEmpty ? Material(
            color: colorTransparent,
            child: ListTile(
              onTap: delete,
              leading: Icon(Icons.delete_outline),
              title: Text(
                textDeleteAvatar,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
          ) : Offstage(),
        ],
      ),
    ),
  );
}