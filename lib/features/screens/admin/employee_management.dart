import 'package:emptychair/cores/constants/constants.dart';
import 'package:emptychair/cores/services/collections.dart';
import 'package:emptychair/cores/services/database.dart';
import 'package:emptychair/cores/shared/button.dart';
import 'package:emptychair/cores/shared/colors.dart';
import 'package:emptychair/cores/shared/size_boxes.dart';
import 'package:emptychair/cores/shared/style.dart';
import 'package:emptychair/features/widgets/delete_dialog.dart';
import 'package:emptychair/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class EmployeeManagement extends StatefulWidget {
  const EmployeeManagement({super.key});

  @override
  State<EmployeeManagement> createState() => _EmployeeManagementState();
}

class _EmployeeManagementState extends State<EmployeeManagement> {
  // bool showPoppup = false;
  @override
  Widget build(BuildContext context) {
    String logo = Hive.box('mt-chair').get('logo', defaultValue: '');
    String bg = Hive.box('mt-chair').get('bg', defaultValue: '');
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
                            Get.toNamed(AppPages.addBarber);
                          },
                          text: 'Add Barber',
                          textColor: white,
                          bgColor: green,
                        ),
                      ),
                      const SizedBoxH20(),
                      SizedBox(
                        width: 150,
                        child: CustomButton(
                          onPressed: () {
                            Get.toNamed(AppPages.removeBarber);
                          },
                          text: 'Remove Barber',
                          textColor: white,
                          bgColor: red,
                        ),
                      ),
                      const SizedBoxH20(),
                      SizedBox(
                        width: 150,
                        child: CustomButton(
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return deletDialog(
                                  context,
                                  deleteAll: true,
                                  onCancel: () {
                                    Navigator.of(context).pop();
                                  },
                                  onDelete: () async {
                                    await FireCollections.barberRef
                                        .get()
                                        .then((value) async {
                                      for (var e in value.docs) {
                                        await DatabaseService.deleteBarber(
                                          barberId: e['id'],
                                        );
                                      }
                                    });

                                    Navigator.of(context).pop();
                                    showToast('All Barber deleted');
                                  },
                                );
                              },
                            );
                          },
                          text: 'Remove All Barber',
                          textColor: white,
                          bgColor: red,
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
                                Get.toNamed(AppPages.adminDashboard);
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
                          // const SizedBox(
                          //   width: 150,
                          // ),
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
