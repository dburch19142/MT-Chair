import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emptychair/cores/constants/constants.dart';
import 'package:emptychair/cores/services/database.dart';
import 'package:emptychair/cores/shared/button.dart';
import 'package:emptychair/cores/shared/colors.dart';
import 'package:emptychair/cores/shared/custom_drop_down.dart';
import 'package:emptychair/cores/shared/size_boxes.dart';
import 'package:emptychair/cores/shared/style.dart';
import 'package:emptychair/cores/shared/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class AddHourScreen extends StatefulWidget {
  const AddHourScreen({super.key});

  @override
  State<AddHourScreen> createState() => _AddHourScreenState();
}

class _AddHourScreenState extends State<AddHourScreen> {
  String day = '';
  TextEditingController start = TextEditingController();
  TextEditingController endControl = TextEditingController();
  bool isLoading = false;
  List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  void addHour() async {
    if (day.isEmpty || start.text.isEmpty || endControl.text.isEmpty) {
      return showErrorToast('Please fill all form');
    }
    setState(() {
      isLoading = true;
    });
    await FirebaseFirestore.instance
        .collection('hours')
        .where('dayIndex', isEqualTo: days.indexOf(day))
        .get()
        .then((value) async {
      if (value.docs.isNotEmpty) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  content: const Text(
                    'Day already exist',
                  ),
                  actions: [
                    TextButton(
                        child: const Text(
                          'Close',
                          style: TextStyle(
                            color: primary,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        })
                  ],
                ));

        setState(() {
          isLoading = false;
        });
      } else {
        try {
          setState(() {
            isLoading = true;
          });
          bool res = await DatabaseService.addhour(
            day: day,
            start: start.text,
            endHour: endControl.text,
            dayIndex: days.indexOf(day),
          );

          if (res) {
            showToast('Hour added successfully');
            setState(() {
              isLoading = false;
              day = '';
              start.clear();
              endControl.clear();
            });
          } else {
            showErrorToast('Error adding hour');
            setState(() {
              isLoading = false;
            });
          }
        } catch (error) {
          setState(() {
            isLoading = false;
          });
          debugPrint(error.toString());
        }
      }
    });
  }

  String formatTimeOfDay(TimeOfDay timeOfDay) {
    final hours = timeOfDay.hourOfPeriod == 0 ? 12 : timeOfDay.hourOfPeriod;
    final minutes = timeOfDay.minute.toString().padLeft(2, '0');
    final period = timeOfDay.period == DayPeriod.am ? 'AM' : 'PM';

    return '$hours:$minutes $period';
  }

  @override
  Widget build(BuildContext context) {
    // String logo = Hive.box('empty').get('logo', defaultValue: '');
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                            color: white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBoxH20(),
                            Text(
                              'Day',
                              style: textStyle14,
                            ),
                            const SizedBoxH10(),
                            CustomDropDown(
                              items: days,
                              val: day,
                              hintText: 'Select day',
                              onChanged: (p0) {
                                setState(() {
                                  day = p0!;
                                });
                              },
                            ),
                            const SizedBoxH20(),
                            Text(
                              'Start time',
                              style: textStyle14,
                            ),
                            const SizedBoxH10(),
                            InkWell(
                              onTap: () async {
                                final TimeOfDay? picked = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (picked != null) {
                                  setState(() {
                                    start.text = formatTimeOfDay(picked);
                                  });
                                }
                              },
                              child: CustomTextField(
                                hintText: 'Select Start Time',
                                enabled: false,
                                controller: start,
                              ),
                            ),
                            const SizedBoxH20(),
                            Text(
                              'End time',
                              style: textStyle14,
                            ),
                            const SizedBoxH10(),
                            InkWell(
                              onTap: () async {
                                final TimeOfDay? picked = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (picked != null) {
                                  setState(() {
                                    endControl.text = formatTimeOfDay(picked);
                                  });
                                }
                              },
                              child: CustomTextField(
                                hintText: 'Select End Time',
                                enabled: false,
                                controller: endControl,
                              ),
                            ),
                            const SizedBoxH20(),
                            isLoading
                                ? const Center(
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: red,
                                      ),
                                    ),
                                  )
                                : Center(
                                    child: SizedBox(
                                      width: 150,
                                      child: CustomButton(
                                        onPressed: () {
                                          addHour();
                                        },
                                        text: 'Add Hour',
                                        textColor: white,
                                        bgColor: green,
                                      ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
