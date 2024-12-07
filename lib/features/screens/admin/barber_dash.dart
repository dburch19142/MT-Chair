import 'package:emptychair/cores/constants/constants.dart';
import 'package:emptychair/cores/shared/button.dart';
import 'package:emptychair/cores/shared/colors.dart';
import 'package:emptychair/cores/shared/size_boxes.dart';
import 'package:emptychair/cores/shared/style.dart';
import 'package:emptychair/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class BarberDashboard extends StatefulWidget {
  const BarberDashboard({super.key});

  @override
  State<BarberDashboard> createState() => _BarberDashboardState();
}

class _BarberDashboardState extends State<BarberDashboard> {
  String logo = Hive.box('mt-chair').get('logo', defaultValue: '');
  String bg = Hive.box('mt-chair').get('bg', defaultValue: '');
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
                            width: width(context) / 4,
                          )
                        : Image.network(
                            logo,
                            width: width(context) / 4,
                          ),
                    const SizedBoxH20(),
                    Text(
                      'Select your appointment time',
                      style: textStyle14,
                    ),
                    const SizedBoxH20(),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: false,
                                onChanged: (value) {},
                              ),
                              // const SizedBoxW20(),
                              Text(
                                'mm/dd/year',
                                style: textStyle14,
                              ),
                            ],
                          ),
                          Text(
                            '(hh.mm am/pm)',
                            style: textStyle14,
                          ),
                        ],
                      ),
                    ),
                    const SizedBoxH20(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 150,
                          child: CustomButton(
                            onPressed: () {},
                            text: 'Home',
                            textColor: white,
                            bgColor: green,
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: CustomButton(
                            onPressed: () {
                              Get.toNamed(AppPages.waitingList);
                            },
                            text: 'Next',
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
    );
  }
}
