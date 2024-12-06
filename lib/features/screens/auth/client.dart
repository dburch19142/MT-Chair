import 'package:emptychair/cores/constants/constants.dart';
import 'package:emptychair/cores/shared/button.dart';
import 'package:emptychair/cores/shared/colors.dart';
import 'package:emptychair/cores/shared/size_boxes.dart';
import 'package:emptychair/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class ClientScreen extends StatefulWidget {
  const ClientScreen({super.key});

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  String logo = Hive.box('empty').get('logo', defaultValue: '');
  String bg = Hive.box('empty').get('bg', defaultValue: '');
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
                backgroundColor: white,
                child: BackButton(
                  color: black,
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                logo == ''
                    ? Image.asset(
                        'assets/images/logo.png',
                        width: width(context) * .8,
                        // width: 140,
                        height: height(context) * .4,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        logo,
                        width: width(context) / .8,
                        // width: 140,
                        height: height(context) * .4,
                      ),
                const SizedBoxH40(),
                SizedBox(
                  width: 300,
                  child: CustomButton(
                    onPressed: () {
                      Get.toNamed(AppPages.signInName);
                    },
                    text: 'Sign In',
                    textColor: white,
                    bgColor: green,
                  ),
                ),
                const SizedBoxH20(),
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
            const SizedBoxH30(),
          ],
        ),
      ),
    );
  }
}
