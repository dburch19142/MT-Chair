import 'package:emptychair/cores/constants/constants.dart';
import 'package:emptychair/cores/shared/button.dart';
import 'package:emptychair/cores/shared/colors.dart';
import 'package:emptychair/cores/shared/size_boxes.dart';
import 'package:emptychair/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class ClientAdminHome extends StatefulWidget {
  const ClientAdminHome({super.key});

  @override
  State<ClientAdminHome> createState() => _ClientAdminHomeState();
}

class _ClientAdminHomeState extends State<ClientAdminHome> {
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
              const Align(
                alignment: Alignment.centerLeft,
                child: SafeArea(
                    child: CircleAvatar(
                  backgroundColor: white,
                  child: BackButton(
                    color: black,
                  ),
                )),
              ),
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
                            Get.toNamed(AppPages.hours);
                          },
                          text: 'Update Hours',
                          textColor: white,
                          bgColor: green,
                        ),
                      ),
                      const SizedBoxH20(),
                      SizedBox(
                        width: 150,
                        child: CustomButton(
                          onPressed: () {
                            Get.toNamed(AppPages.services);
                          },
                          text: 'Update Service',
                          textColor: white,
                          bgColor: secondaryPurple,
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
                                Get.toNamed(AppPages.adminStarted);
                              },
                              text: 'Exit',
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
