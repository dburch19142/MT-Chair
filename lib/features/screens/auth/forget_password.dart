import 'dart:developer';

import 'package:emptychair/cores/constants/constants.dart';
import 'package:emptychair/cores/shared/button.dart';
import 'package:emptychair/cores/shared/colors.dart';
import 'package:emptychair/cores/shared/size_boxes.dart';
import 'package:emptychair/cores/shared/style.dart';
import 'package:emptychair/cores/shared/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  String logo = Hive.box('empty').get('logo', defaultValue: '');
  String bg = Hive.box('empty').get('bg', defaultValue: '');
  bool isLoading = false;
  bool showPassword = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void resendLink() async {
    try {
      setState(() {
        isLoading = true;
      });
      await FirebaseAuth.instance
          .sendPasswordResetEmail(
        email: email.text,
      )
          .then((value) {
        setState(() {
          isLoading = false;
        });

        showToast('Password reset link has been sent');
        // }
      });
    } on FirebaseException catch (e) {
      log(e.toString());
      // debugPrint(e.message);
      setState(() {
        isLoading = false;
      });
      showErrorToast(e.message ?? 'Something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width(context),
        height: height(context),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          image: bg == ''
              ? const DecorationImage(
                  image: AssetImage('assets/images/bg.png'),
                  fit: BoxFit.cover,
                )
              : DecorationImage(
                  image: NetworkImage(bg),
                  fit: BoxFit.cover,
                ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: CircleAvatar(
                      backgroundColor: white,
                      child: BackButton(
                        color: black,
                      )),
                ),
                const SizedBoxH20(),
                logo == ''
                    ? Image.asset(
                        'assets/images/logo.png',
                        width: width(context) * .2,
                        // width: 140,
                        height: height(context) * .2,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        logo,
                        width: width(context) / .2,
                        // width: 140,
                        height: height(context) * .2,
                      ),
                const SizedBoxH40(),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: white,
                    ),
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email',
                          style: textStyle14,
                        ),
                        const SizedBoxH10(),
                        CustomTextField(
                          hintText: 'Email address',
                          controller: email,
                        ),
                        const SizedBoxH10(),
                        const SizedBoxH20(),
                        isLoading
                            ? const Center(
                                child: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: CircularProgressIndicator(
                                      color: primary,
                                    )),
                              )
                            : CustomButton(
                                onPressed: () {
                                  if (email.text.isEmail) {
                                    resendLink();
                                  } else {
                                    showErrorToast('Invalid email');
                                  }
                                },
                                text: 'Send Reset Link',
                                textColor: white,
                                bgColor: green,
                              ),
                      ],
                    )),

                // const SizedBoxH20(),
                // SizedBox(
                //   width: 150,
                //   child: CustomButton(
                //     onPressed: () {
                //       Get.toNamed(AppPages.adminDashboard);
                //     },
                //     text: 'Admin',
                //     textColor: white,
                //     bgColor: red,
                //   ),
                // ),
                // SizedBox(
                //   width: 150,
                //   child: CustomButton(
                //     onPressed: () {
                //       Get.toNamed(AppPages.waitingList);
                //     },
                //     text: 'Wait',
                //     textColor: white,
                //     bgColor: red,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
