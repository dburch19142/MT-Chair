import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:emptychair/cores/constants/constants.dart';
import 'package:emptychair/cores/services/database.dart';
import 'package:emptychair/cores/shared/button.dart';
import 'package:emptychair/cores/shared/colors.dart';
import 'package:emptychair/cores/shared/size_boxes.dart';
import 'package:emptychair/cores/shared/style.dart';
import 'package:emptychair/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class UpdateLogoScreen extends StatefulWidget {
  const UpdateLogoScreen({super.key});

  @override
  State<UpdateLogoScreen> createState() => _UpdateLogoScreenState();
}

class _UpdateLogoScreenState extends State<UpdateLogoScreen> {
  TextEditingController name = TextEditingController();
  File? file;
  bool isLoading = false;

  void addBarber() async {
    if (file == null) {
      return showErrorToast('Please select photo');
    }

    try {
      setState(() {
        isLoading = true;
      });
      bool res = await DatabaseService.updateLogo(file: file!);

      if (res) {
        showToast('Logo updated');
        setState(() {
          isLoading = false;
        });
        Get.toNamed(AppPages.signIn);
      } else {
        showErrorToast('Error uploading bg');
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      debugPrint(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // String logo = Hive.box('empty').get('logo', defaultValue: '');
    String bg = Hive.box('empty').get('bg', defaultValue: '');
    return Scaffold(
      body: Container(
        width: width(context),
        height: height(context),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: bg == ''
              ? const DecorationImage(
                  image: AssetImage('assets/images/bg.png'),
                  fit: BoxFit.cover,
                )
              : DecorationImage(
                  image: NetworkImage(
                    bg,
                  ),
                  fit: BoxFit.cover,
                ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBoxH20(),
                    Container(
                        padding: const EdgeInsets.all(20),
                        width: width(context),
                        decoration: BoxDecoration(
                            color: const Color(0xffD9D9D9),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Container(
                              width: 240,
                              height: 281,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xffcccccc),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: file == null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            final ImagePicker picker =
                                                ImagePicker();
                                            final XFile? image =
                                                await picker.pickImage(
                                                    source:
                                                        ImageSource.gallery);
                                            setState(() {
                                              file = File(image!.path);
                                            });
                                          },
                                          child: DottedBorder(
                                            borderType: BorderType.RRect,
                                            radius: const Radius.circular(15),
                                            child: const SizedBox(
                                              width: 102,
                                              height: 102,
                                              child: Icon(
                                                Icons.add,
                                                color: black,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  : SizedBox(
                                      child: Image.file(
                                        file!,
                                      ),
                                    ),
                            ),
                            const SizedBoxH20(),
                            isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: red,
                                    ),
                                  )
                                : SizedBox(
                                    width: 150,
                                    child: CustomButton(
                                      onPressed: () {
                                        addBarber();
                                      },
                                      text: 'Change Logo',
                                      textColor: white,
                                      bgColor: blue,
                                    ),
                                  ),
                            const SizedBoxH20(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: CustomButton(
                                    onPressed: () {
                                      Get.toNamed(AppPages.signIn);
                                    },
                                    text: 'Home',
                                    textColor: white,
                                    bgColor: green,
                                  ),
                                ),
                                SizedBox(
                                  width: 150,
                                  child: CustomButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    text: 'Back',
                                    textColor: white,
                                    bgColor: red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
