import 'package:emptychair/cores/constants/constants.dart';
import 'package:emptychair/cores/shared/button.dart';
import 'package:emptychair/cores/shared/colors.dart';
import 'package:emptychair/cores/shared/size_boxes.dart';
import 'package:emptychair/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class AdminStarterScreen extends StatefulWidget {
  const AdminStarterScreen({super.key});

  @override
  State<AdminStarterScreen> createState() => _AdminStarterScreenState();
}

class _AdminStarterScreenState extends State<AdminStarterScreen> {
  // bool showPoppup = false;
  @override
  Widget build(BuildContext context) {
    String logo = Hive.box('empty').get('logo', defaultValue: '');
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
                  image: NetworkImage(bg),
                  fit: BoxFit.cover,
                ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(
              //   'assets/images/logo.png',
              //   width: width(context) / 3,
              // ),
              // SizedBox(
              //   height: height(context) * .1,
              // ),
              Container(
                  padding: const EdgeInsets.all(20),
                  width: width(context),
                  decoration: BoxDecoration(
                      color: const Color(0xffD9D9D9),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      logo == ''
                          ? Image.asset(
                              'assets/images/logo.png',
                              width: width(context) / 5,
                            )
                          : Image.network(
                              logo,
                              width: width(context) / 5,
                            ),
                      const SizedBoxH20(),
                      SizedBox(
                        width: 150,
                        child: CustomButton(
                          onPressed: () {
                            Get.toNamed(AppPages.checkIn);
                          },
                          text: 'Check In',
                          textColor: white,
                          bgColor: green,
                        ),
                      ),
                      const SizedBoxH20(),
                      SizedBox(
                        width: 150,
                        child: CustomButton(
                          onPressed: () {
                            Get.toNamed(AppPages.barberClockIn);
                          },
                          text: 'Barber Clock In/Out',
                          textColor: white,
                          bgColor: secondaryPurple,
                        ),
                      ),
                      const SizedBoxH20(),
                      SizedBox(
                        width: 150,
                        child: CustomButton(
                          onPressed: () {
                            Get.toNamed(AppPages.adminLogin);
                          },
                          text: 'Admin',
                          textColor: white,
                          bgColor: black,
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
                          const SizedBox(
                            width: 150,
                          ),
                        ],
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
