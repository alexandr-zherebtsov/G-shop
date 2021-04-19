import 'dart:io';
import 'package:flutter/material.dart';
import 'package:g_shop/constants/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

Widget getImageWidget(Function func, bool isAsset, {Asset e, String url, PickedFile file}) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      isAsset ? imageWidget(e) : imageNetworkWidget(url),
      Positioned(
        top: 4,
        left: 4,
        child: InkWell(
          hoverColor: colorTransparent,
          highlightColor: colorTransparent,
          splashColor: colorTransparent,
          focusColor: colorTransparent,
          onTap: func,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: colorRed,
              borderRadius: BorderRadius.circular(18.0),
            ),
            child: Icon(
              Icons.clear,
              color: colorWhite,
              size: 16,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget getPickedImageWidget(PickedFile file, Function func) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      imageNetworkWidget('', isNetwork: false, file: file),
      Positioned(
        top: 4,
        left: 4,
        child: InkWell(
          hoverColor: colorTransparent,
          highlightColor: colorTransparent,
          splashColor: colorTransparent,
          focusColor: colorTransparent,
          onTap: func,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: colorRed,
              borderRadius: BorderRadius.circular(18.0),
            ),
            child: Icon(
              Icons.clear,
              color: colorWhite,
              size: 16,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget imageWidget(Asset e) {
  double size = 58.0;
  return Container(
    width: size,
    height: size,
    clipBehavior: Clip.hardEdge,
    margin: const EdgeInsets.all(4.0),
    decoration: BoxDecoration(
      color: colorBlack.withOpacity(0.1),
      borderRadius: BorderRadius.circular(3.0),
    ),
    child: AssetThumb(
      width: size.toInt(),
      height: size.toInt(),
      asset: e,
      quality: 100,
      spinner: Container(
        width: size,
        height: size,
        padding: const EdgeInsets.all(4.0),
        child: CircularProgressIndicator(),
      ),
    ),
  );
}

Widget imageNetworkWidget(String url, {bool isNetwork = true, PickedFile file}) {
  double size = 58.0;
  return Container(
    width: size,
    height: size,
    clipBehavior: Clip.hardEdge,
    margin: const EdgeInsets.all(4.0),
    decoration: BoxDecoration(
      color: colorBlack.withOpacity(0.1),
      borderRadius: BorderRadius.circular(3.0),
    ),
    child: isNetwork ? Image.network(
      url,
      width: size,
      height: size,
      fit: BoxFit.cover,
      loadingBuilder: (
        BuildContext context,
        Widget child,
        ImageChunkEvent loadingProgress,
      ) {
        if (loadingProgress == null) return child;
        return Center(child: CircularProgressIndicator());
      },
      errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
        return Center(
          child: Icon(
            Icons.error_outline,
            size: 40,
          ),
        );
      },
    ) : file != null ? Image.file(
      File(file.path),
      width: size,
      height: size,
      fit: BoxFit.cover,
      frameBuilder: (BuildContext context, Widget child, int frame, bool wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) return child;
        return AnimatedOpacity(
          opacity: frame == null ? 0 : 1,
          duration: Duration(milliseconds: 1400),
          curve: Curves.easeOut,
          child: child,
        );
      },
      errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
        return Center(
          child: Icon(
            Icons.error_outline,
            size: 40,
          ),
        );
      },
    ) : Offstage(),
  );
}
