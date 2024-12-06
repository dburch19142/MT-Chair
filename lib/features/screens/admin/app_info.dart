import 'dart:developer';

import 'package:emptychair/cores/constants/constants.dart';
import 'package:emptychair/cores/shared/button.dart';
import 'package:emptychair/cores/shared/colors.dart';
import 'package:emptychair/cores/shared/size_boxes.dart';
import 'package:emptychair/cores/shared/style.dart';
import 'package:emptychair/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart';

class AppInfoScreen extends StatefulWidget {
  const AppInfoScreen({super.key});

  @override
  State<AppInfoScreen> createState() => _AppInfoScreenState();
}

class _AppInfoScreenState extends State<AppInfoScreen> {
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
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'This app was developed by ',
                                style: textStyle16,
                              ),
                              Text(
                                'BurchTech',
                                style: textStyle16.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBoxH5(),
                          Column(
                            children: [
                              Text(
                                'For additional information about this app, goto',
                                style: textStyle16,
                                textAlign: TextAlign.center,
                              ),
                              InkWell(
                                  onTap: () async {
                                    String url = 'https://www.mt-chair.com';

                                    try {
                                      if (await canLaunchUrl(Uri.parse(url))) {
                                        await launchUrl(Uri.parse(url));
                                      }
                                    } catch (error) {
                                      log("Cannot launch url");
                                    }
                                  },
                                  child: Text(
                                    'www.MT-Chair.com',
                                    style: textStyle16.copyWith(color: primary),
                                  )),
                            ],
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
