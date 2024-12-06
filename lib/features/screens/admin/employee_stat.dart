import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:intl/intl.dart';

class EmployeeStatScreen extends StatefulWidget {
  const EmployeeStatScreen({super.key});

  @override
  State<EmployeeStatScreen> createState() => _EmployeeStatScreenState();
}

class _EmployeeStatScreenState extends State<EmployeeStatScreen> {
  final f = DateFormat.yMd();

  @override
  Widget build(BuildContext context) {
    // String logo = Hive.box('empty').get('logo', defaultValue: '');
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
        child: StreamBuilder<QuerySnapshot>(
            stream: DatabaseService().getAllBarbersStream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: Text('No data available'),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: red,
                    ),
                  ),
                );
              }
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image.asset(
                    //   'assets/images/logo.png',
                    //   width: width(context) / 3,
                    // ),
                    SizedBox(
                      height: height(context) * .1,
                    ),
                    Container(
                        padding: const EdgeInsets.all(20),
                        width: width(context),
                        decoration: BoxDecoration(
                            color: const Color(0xffD9D9D9),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            // Text(
                            //   'You are now signed in',
                            //   textAlign: TextAlign.center,
                            //   style: textStyle14.copyWith(fontSize: 20),
                            // ),
                            // const SizedBoxH20(),
                            // Text(
                            //   'Please have a seat and your barber will be with you as soon as possible.',
                            //   textAlign: TextAlign.center,
                            //   style: textStyle14.copyWith(
                            //     fontSize: 16,
                            //   ),
                            // ),
                            const SizedBoxH20(),
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'NAMES',
                                          style: textStyle12.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          'CURRENT WEEK',
                                          style: textStyle12.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          'CURRENT MONTH',
                                          style: textStyle12.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          'YEAR TO DATE',
                                          style: textStyle12.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      var data = snapshot.data!.docs;

                                      return StatItem(
                                        barberId: data[index]['id'],
                                        barberName: data[index]['name'],
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        const SizedBoxH10(),
                                    itemCount: snapshot.data!.docs.length,
                                  )
                                ],
                              ),
                            ),
                            // const SizedBoxH10(),
                            // Container(
                            //   padding: const EdgeInsets.all(5),
                            //   decoration: BoxDecoration(
                            //     color: white,
                            //     borderRadius: BorderRadius.circular(10),
                            //   ),
                            //   child: Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //     children: [],
                            //   ),
                            // ),
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
              );
            }),
      ),
    );
  }
}

class StatItem extends StatefulWidget {
  final String barberId;
  final String barberName;
  const StatItem({super.key, required this.barberId, required this.barberName});

  @override
  State<StatItem> createState() => _StatItemState();
}

class _StatItemState extends State<StatItem> {
  DateTime now = DateTime.now();
  String countWeek = '0';
  String countMonth = '0';
  String countYear = '0';

  void getStat() async {
    await DatabaseService.getStat(
      selectedDate: now,
      toSelectedDate: now.subtract(const Duration(days: 7)),
      barberId: widget.barberId,
    ).then((value) {
      setState(() {
        countWeek = value.length.toString();
      });
    });
    await DatabaseService.getStat(
      selectedDate: now,
      toSelectedDate: now.subtract(const Duration(days: 31)),
      barberId: widget.barberId,
    ).then((value) {
      setState(() {
        countMonth = value.length.toString();
      });
    });
    await DatabaseService.getStat(
      selectedDate: now,
      toSelectedDate: now.subtract(const Duration(days: 365)),
      barberId: widget.barberId,
    ).then((value) {
      setState(() {
        countYear = value.length.toString();
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              widget.barberName,
              style: textStyle12,
            ),
          ),
          Expanded(
            child: Text(
              countWeek,
              style: textStyle12,
            ),
          ),
          Expanded(
            child: Text(
              countMonth,
              style: textStyle12,
            ),
          ),
          Expanded(
            child: Text(
              countYear,
              style: textStyle12,
            ),
          ),
        ],
      ),
    );
  }
}
