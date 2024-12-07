import 'dart:developer';

import 'package:emptychair/cores/constants/constants.dart';
import 'package:emptychair/cores/shared/button.dart';
import 'package:emptychair/cores/shared/colors.dart';
import 'package:emptychair/cores/shared/size_boxes.dart';
import 'package:emptychair/cores/shared/style.dart';
import 'package:emptychair/cores/shared/textfield.dart';
import 'package:emptychair/cores/shared/textfield_password.dart';
import 'package:emptychair/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  String logo = Hive.box('mt-chair').get('logo', defaultValue: '');
  String bg = Hive.box('mt-chair').get('bg', defaultValue: '');
  bool isLoading = false;
  bool showPassword = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void login() async {
    try {
      setState(() {
        isLoading = true;
      });
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      )
          .then((value) {
        setState(() {
          isLoading = false;
        });

        Get.toNamed(AppPages.adminDashboard);
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
                        const SizedBoxH20(),
                        Text(
                          'Password',
                          style: textStyle14,
                        ),
                        const SizedBoxH10(),
                        CustomTextFieldPassword(
                          hintText: 'Password',
                          controller: password,
                          obsecure: showPassword,
                          suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              },
                              child: Icon(showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off)),
                        ),
                        const SizedBoxH10(),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Get.toNamed(AppPages.forgetPassword);
                            },
                            child: Text(
                              'Forgot password?',
                              style: textStyle14.copyWith(
                                color: red,
                              ),
                            ),
                          ),
                        ),
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
                                  login();
                                },
                                text: 'Login In',
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
