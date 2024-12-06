import 'package:emptychair/cores/constants/constants.dart';
import 'package:emptychair/cores/shared/button.dart';
import 'package:emptychair/cores/shared/colors.dart';
import 'package:emptychair/cores/shared/size_boxes.dart';
import 'package:emptychair/cores/shared/style.dart';
import 'package:emptychair/cores/shared/textfield.dart';
import 'package:emptychair/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class SignInNameScreen extends StatefulWidget {
  const SignInNameScreen({super.key});

  @override
  State<SignInNameScreen> createState() => _SignInNameScreenState();
}

class _SignInNameScreenState extends State<SignInNameScreen> {
  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String logo = Hive.box('empty').get('logo', defaultValue: '');
    String bg = Hive.box('empty').get('bg', defaultValue: '');

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              logo == ''
                  ? Image.asset(
                      'assets/images/logo.png',
                      width: width(context) / 3,
                    )
                  : Image.network(
                      logo,
                      width: width(context) / 3,
                    ),
              SizedBox(
                height: height(context) * .1,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: const Color(0xffD9D9D9),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    CustomTextField(
                      hintText: 'Enter name',
                      controller: name,
                    ),
                    const SizedBoxH20(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 150,
                          child: CustomButton(
                            onPressed: () {
                              Get.back();
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
                              if (name.text.isEmpty) {
                                return showErrorToast('Name is required');
                              } else {
                                Get.offAndToNamed(
                                  AppPages.selectBarber,
                                  arguments: {"name": name.text},
                                );
                              }
                            },
                            text: 'Next',
                            textColor: white,
                            bgColor: red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
