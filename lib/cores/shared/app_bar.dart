import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:emptychair/cores/shared/colors.dart';
import 'package:emptychair/cores/shared/size_boxes.dart';
import 'package:emptychair/cores/shared/style.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      actions: const <Widget>[
        Icon(
          MdiIcons.bellBadge,
        ),
        Icon(MdiIcons.account),
      ],
    );
  }
}

AppBar defaulAappBar(
    {required Widget title,
    required Widget action,
    // BuildContext? context,
    bool? centerTile,
    bool showBack = false}) {
  return AppBar(
    titleTextStyle:
        textStyle18.copyWith(fontWeight: FontWeight.w800, color: black),
    backgroundColor: const Color(0xffF7F7F7),
    elevation: 0,
    foregroundColor: black,
    centerTitle: centerTile ?? false,
    leading: showBack
        ? InkWell(
            onTap: () {
              // Navigator.pop(context!);
            },
            child: Icon(
              Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
              color: black,
            ),
          )
        : null,
    title: title,
    actions: <Widget>[
      action,
      const SizedBoxW20(),
    ],
  );
}

AppBar appBar2({
  required String title,
}) {
  return AppBar(
    leading: const SizedBox.shrink(),
    backgroundColor: white,
    foregroundColor: black,
    elevation: 1,
    centerTitle: true,
    title: Text(title),
    actions: <Widget>[
      InkWell(
          onTap: () {
            // Get.back();
          },
          child: const Icon(Icons.close)),
      const SizedBoxW15(),
    ],
  );
}

AppBar appBar3({required String title, Widget? action, Widget? leading}) {
  return AppBar(
    leading: leading,
    backgroundColor: white,
    foregroundColor: black,
    elevation: 1,
    centerTitle: true,
    title: Text(title),
    actions: <Widget>[
      InkWell(
        onTap: () {
          // Get.back();
        },
        child: action,
      ),
      const SizedBoxW15(),
    ],
  );
}
