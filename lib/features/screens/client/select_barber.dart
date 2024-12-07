import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emptychair/cores/constants/constants.dart';
import 'package:emptychair/cores/services/collections.dart';
import 'package:emptychair/cores/services/database.dart';
import 'package:emptychair/cores/shared/button.dart';
import 'package:emptychair/cores/shared/colors.dart';
import 'package:emptychair/cores/shared/size_boxes.dart';
import 'package:emptychair/cores/shared/style.dart';
import 'package:emptychair/features/widgets/appointment_dialog.dart';
import 'package:emptychair/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class SelectBarberScreen extends StatefulWidget {
  const SelectBarberScreen({super.key});

  @override
  State<SelectBarberScreen> createState() => _SelectBarberScreenState();
}

class _SelectBarberScreenState extends State<SelectBarberScreen> {
  // bool showPoppup = false;
  String barberId = '';
  String barberName = '';
  String name = '';
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      name = Get.arguments['name'];
    });
    // print('name ' + Get.arguments['name']);
  }

  void addQueue({required String id, required String barberNamee}) async {
    // if (dateController.text.isEmpty) {
    //   return showErrorToast('Please enter date')
    // }

    try {
      setState(() {
        isLoading = true;
      });
      // print(dateController.text);
      Map<String, dynamic> data = {
        'barberName': barberNamee,
        'barberId': id,
        'type': 'walk-in',
        'clientName': name,
        'createdAt': Timestamp.now(),
        'appointmentDate': Timestamp.now(),
        'appointmentTime': '00pm',
        'status': 'waiting'
      };
      print(data);

      var res = await DatabaseService.addQueue(data: data);
      if (res) {
        showToast('Booking successful');
        Get.offAndToNamed(AppPages.waitingList);
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        showErrorToast('Error in booking appointment');
      }
    } catch (e) {
      debugPrint(e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // String logo = Hive.box('mt-chair').get('logo', defaultValue: '');
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
        child: LayoutBuilder(builder: (context, constraints) {
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Select your barber  or click ',
                            style: textStyle14.copyWith(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            '‘First Available’',
                            style: textStyle14.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBoxH20(),
                      SizedBox(
                        height: height(context) * .6,
                        child: StreamBuilder<QuerySnapshot>(
                            stream:
                                DatabaseService().getAvailableBarbersStream(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: Text('No barber available'),
                                );
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
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

                              return snapshot.data!.docs.isEmpty
                                  ? const Center(
                                      child: Text(
                                          'No barber available, please add barber'),
                                    )
                                  : GridView.builder(
                                      // scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.docs.length,
                                      controller: ScrollController(
                                          keepScrollOffset: false),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount:
                                            constraints.maxWidth <= 768 ? 2 : 4,
                                        mainAxisSpacing: 20.0,
                                        crossAxisSpacing: 80.0,
                                        childAspectRatio: 0.65,
                                      ),
                                      itemBuilder: (context, index) {
                                        var data = snapshot.data!.docs;
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              barberId = data[index]['id'];
                                              barberName = data[index]['name'];
                                            });
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AppointmentWidget(
                                                  onYes: () {
                                                    // print(Get.arguments['name']);

                                                    Get.offAndToNamed(
                                                      AppPages.appointmentTime,
                                                      arguments: {
                                                        'name': name,
                                                        'barberId': barberId,
                                                        'type': 'appointment',
                                                        'barberName': barberName
                                                      },
                                                    );
                                                  },
                                                  isLoading: isLoading,
                                                  onNo: () async {
                                                    Navigator.of(context).pop();
                                                    addQueue(
                                                      id: barberId,
                                                      barberNamee: barberName,
                                                    );
                                                  },
                                                );
                                              },
                                            );
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                              color: white,
                                              border: Border.all(
                                                width: 2,
                                                color: barberId ==
                                                        data[index]['id']
                                                    ? red
                                                    : white,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Image.network(
                                                        data[index]
                                                            ['photo_url'],
                                                        // width: width(context),
                                                        // height: 110,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                // const SizedBoxH10(),
                                                Container(
                                                  width: width(context),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 10,
                                                    vertical: 5,
                                                  ),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: blue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                  ),
                                                  child: Text(
                                                    data[index]['name'],
                                                    style: textStyle14.copyWith(
                                                      color: white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                            }),
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
                          isLoading
                              ? const SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: CircularProgressIndicator())
                              : SizedBox(
                                  width: 150,
                                  child: CustomButton(
                                    onPressed: () async {
                                      QuerySnapshot snapshot =
                                          await FireCollections.barberRef.get();
                                      int totalDocs = snapshot.docs.length;
                                      int randomIndex =
                                          Random().nextInt(totalDocs);
                                      var snap = snapshot.docs[randomIndex];

                                      setState(() {
                                        barberId = snap['id'];
                                        barberName = snap['name'];
                                      });
                                      addQueue(
                                          id: "First Available",
                                          barberNamee: "First Available");
                                    },
                                    text: 'First Available',
                                    textColor: white,
                                    bgColor: red,
                                  ),
                                )
                          // : const SizedBox(
                          //     width: 150,
                          //   ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
