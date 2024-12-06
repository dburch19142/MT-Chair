import 'package:flutter/material.dart';
import 'package:emptychair/cores/shared/colors.dart';
import 'package:get/get.dart';

TextStyle headerStyle = const TextStyle(fontSize: 35, fontWeight: FontWeight.w700);
TextStyle subHeaderStyle =
    const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500);

TextStyle textStyle8 = const TextStyle(
  fontSize: 8.0,
);
TextStyle textStyle10 = const TextStyle(fontSize: 10.0);
TextStyle textStyle12 = const TextStyle(fontSize: 12.0);
TextStyle textStyle14 = const TextStyle(fontSize: 14.0);
TextStyle textStyle16 = const TextStyle(fontSize: 16.0);
TextStyle textStyle18 = const TextStyle(fontSize: 18.0);

TextStyle bold20 = const TextStyle(fontWeight: FontWeight.w700, fontSize: 20);
void showToast(String label) {
  Get.snackbar(
    "Success",
    label,
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.green,
    borderRadius: 10,
    isDismissible: true,
    margin: const EdgeInsets.all(20),
    colorText: white,
    snackStyle: SnackStyle.FLOATING,
    duration: const Duration(seconds: 2),
  );
}

void showErrorToast(String label) {
  Get.snackbar(
    'Error',
    label,
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.red,
    borderRadius: 10,
    isDismissible: true,
    margin: const EdgeInsets.all(20),
    colorText: white,
    snackStyle: SnackStyle.FLOATING,
    duration: const Duration(seconds: 2),
  );
}

OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: const BorderSide(color: warGrey),
);

UnderlineInputBorder underlineInputBorder = const UnderlineInputBorder(
  borderSide: BorderSide(color: black),
);

InputBorder noborder = InputBorder.none;

defaultDialog(
    {required Widget children,
    MainAxisAlignment? mAxis,
    CrossAxisAlignment? cAxis,
    required BuildContext context}) {
  return;
  // return Get.dialog(Dialog(
  //   child: Padding(
  //     padding: const EdgeInsets.all(20.0),
  //     child: Column(
  //       mainAxisAlignment: mAxis ?? MainAxisAlignment.center,
  //       crossAxisAlignment: cAxis ?? CrossAxisAlignment.center,
  //       mainAxisSize: MainAxisSize.min,
  //       children: [children],
  //     ),
  //   ),
  // ));
}
