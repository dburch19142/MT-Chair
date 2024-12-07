// import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emptychair/cores/constants/constants.dart';
import 'package:emptychair/cores/services/collections.dart';
import 'package:emptychair/cores/services/database.dart';
import 'package:emptychair/cores/shared/button.dart';
import 'package:emptychair/cores/shared/colors.dart';
import 'package:emptychair/cores/shared/size_boxes.dart';
import 'package:emptychair/cores/shared/style.dart';
import 'package:emptychair/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class CheckInListScreen extends StatefulWidget {
  const CheckInListScreen({super.key});

  @override
  State<CheckInListScreen> createState() => _CheckInListScreenState();
}

class _CheckInListScreenState extends State<CheckInListScreen> {
  final f = DateFormat.yMd();
  final timeF = DateFormat.jm();
  String barberId = '';
  String barberName = '';
  String selectedBooking = '';
  String selectedBookingBarberName = '';
  String selectedBookingBarberId = '';
  List requests = [];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      barberId = Get.arguments['barberId'];
      barberName = Get.arguments['barberName'];
    });
    getList();
    // print(requests[0]);
    // print(barberId);
  }

  void getList() async {
    await FireCollections.bookingRef
        .where('status', isEqualTo: 'waiting')
        // .orderBy('createdAt', descending: true)
        .orderBy('appointmentDate', descending: true)
        // .where('barberId', isEqualTo: barberId)
        .get()
        .then((value) {
      for (var element in value.docs) {
        requests.add(element);
      }
    });
    // await FireCollections.bookingRef
    //     .where('status', isEqualTo: 'waiting')
    //     .where('barberId', isEqualTo: "First Available")
    //     .get()
    //     .then((value) {
    //   for (var element in value.docs) {
    //     requests.add(element);
    //   }
    // });
    setState(() {});
    // print(requests);
  }

  @override
  Widget build(BuildContext context) {
    // String logo = Hive.box('mt-chair').get('logo', defaultValue: '');
    String bg = Hive.box('mt-chair').get('bg', defaultValue: '');
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Container(
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
          // child: StreamBuilder<QuerySnapshot>(
          //     stream: DatabaseService().getBarberQueue(barberId: barberId),
          //     builder: (context, snapshot) {
          //       if (!snapshot.hasData) {
          //         return const Center(
          //           child: Text('No data available'),
          //         );
          //       }
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return const Center(
          //           child: SizedBox(
          //             width: 20,
          //             height: 20,
          //             child: CircularProgressIndicator(
          //               color: red,
          //             ),
          //           ),
          //         );
          //       }
          //       return
          child: SingleChildScrollView(
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
                    height: height(context) * .8,
                    padding: const EdgeInsets.all(20),
                    width: width(context),
                    decoration: BoxDecoration(
                        color: const Color(0xffD9D9D9),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Text(
                          'Select who you wish to sign in',
                          textAlign: TextAlign.center,
                          style: textStyle14.copyWith(fontSize: 20),
                        ),
                        const SizedBoxH20(),
                        // Text(
                        //   'Please have a seat and your barber will be with you as soon as possible.',
                        //   textAlign: TextAlign.center,
                        //   style: textStyle14.copyWith(
                        //     fontSize: 16,
                        //   ),
                        // ),
                        // const SizedBoxH20(),
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
                                      '',
                                      style: textStyle12.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: constraints.maxWidth <= 768
                                            ? 8
                                            : 12,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'CLIENT',
                                      style: textStyle12.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: constraints.maxWidth <= 768
                                            ? 8
                                            : 12,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'BARBER',
                                      style: textStyle12.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: constraints.maxWidth <= 768
                                            ? 8
                                            : 12,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'STATUS',
                                      style: textStyle12.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: constraints.maxWidth <= 768
                                            ? 8
                                            : 12,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'SIGNIN TIME',
                                      style: textStyle12.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: constraints.maxWidth <= 768
                                            ? 8
                                            : 12,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'APPOINT. TIME',
                                      style: textStyle12.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: constraints.maxWidth <= 768
                                            ? 8
                                            : 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var data = requests;
                                  Timestamp timestamp =
                                      data[index]['appointmentDate'];
                                  int time = timestamp.millisecondsSinceEpoch;
                                  var date =
                                      DateTime.fromMillisecondsSinceEpoch(time);
                                  // var dateformat = f.format(date);
                                  var dateTime = timeF.format(date);
                                  return Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Checkbox(
                                            value: selectedBooking ==
                                                    data[index]['id'].toString()
                                                ? true
                                                : false,
                                            onChanged: (value) {
                                              if (selectedBooking ==
                                                  data[index]['id']) {
                                                setState(() {
                                                  selectedBooking = '';
                                                  selectedBookingBarberId = '';
                                                  selectedBookingBarberName =
                                                      '';
                                                });
                                              } else {
                                                setState(() {
                                                  selectedBooking =
                                                      data[index]['id'];

                                                  selectedBookingBarberId =
                                                      data[index]['barberId'];
                                                  selectedBookingBarberName =
                                                      data[index]['barberName'];
                                                });
                                              }
                                            },
                                          ),
                                        ), //todo
                                        Expanded(
                                          child: Text(
                                            data[index]['clientName'],
                                            style: textStyle12.copyWith(
                                              fontSize:
                                                  constraints.maxWidth <= 768
                                                      ? 8
                                                      : 12,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            data[index]['barberName'],
                                            style: textStyle12.copyWith(
                                              fontSize:
                                                  constraints.maxWidth <= 768
                                                      ? 8
                                                      : 12,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            data[index]['type'],
                                            overflow: TextOverflow.ellipsis,
                                            style: textStyle12.copyWith(
                                              fontSize:
                                                  constraints.maxWidth <= 768
                                                      ? 8
                                                      : 12,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            dateTime,
                                            style: textStyle12.copyWith(
                                              fontSize:
                                                  constraints.maxWidth <= 768
                                                      ? 8
                                                      : 12,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            data[index]['appointmentTime'] ==
                                                    '00pm'
                                                ? ''
                                                : data[index]
                                                    ['appointmentTime'],
                                            style: textStyle12.copyWith(
                                              fontSize:
                                                  constraints.maxWidth <= 768
                                                      ? 8
                                                      : 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBoxH10(),
                                itemCount: requests.length,
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
                            isLoading
                                ? const SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator())
                                : SizedBox(
                                    width: 150,
                                    child: CustomButton(
                                      onPressed: () async {
                                        if (selectedBooking.isEmpty) {
                                          return showErrorToast(
                                              'Please select a sign in');
                                        }
                                        if (selectedBookingBarberId ==
                                            "First Available") {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          var res =
                                              await DatabaseService.updateQueue(
                                                  id: selectedBooking,
                                                  firstAvailable: true,
                                                  barberId: barberId,
                                                  barberName: barberName);
                                          // Get.back();
                                          if (res) {
                                            setState(() {
                                              isLoading = false;
                                            });
                                            await Future.delayed(
                                              const Duration(
                                                seconds: 1,
                                              ),
                                            ).then((value) => {
                                                  Get.toNamed(
                                                    AppPages.signIn,
                                                  ),
                                                });
                                            showToast('Client sign in');
                                          } else {
                                            setState(() {
                                              isLoading = false;
                                            });
                                            showErrorToast('An error occured');
                                          }
                                        } else {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          var res =
                                              await DatabaseService.updateQueue(
                                            id: selectedBooking,
                                            firstAvailable: true,
                                            barberId: barberId,
                                            barberName: barberName,
                                          );
                                          // Get.back();
                                          if (res) {
                                            setState(() {
                                              isLoading = false;
                                            });
                                            await Future.delayed(
                                              const Duration(
                                                seconds: 1,
                                              ),
                                            ).then((value) => {
                                                  Get.toNamed(
                                                    AppPages.signIn,
                                                  ),
                                                });
                                            showToast('Client sign in');
                                          } else {
                                            setState(() {
                                              isLoading = false;
                                            });
                                            showErrorToast('An error occured');
                                          }
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
                    )),
              ],
            ),
          ),
        );
      }),
    );
  }
}
