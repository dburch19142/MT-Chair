import 'package:emptychair/cores/constants/constants.dart';
import 'package:emptychair/cores/services/database.dart';
import 'package:emptychair/cores/shared/button.dart';
import 'package:emptychair/cores/shared/colors.dart';
import 'package:emptychair/cores/shared/custom_drop_down.dart';
import 'package:emptychair/cores/shared/size_boxes.dart';
import 'package:emptychair/cores/shared/style.dart';
import 'package:emptychair/cores/shared/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class UpdateHourScreen extends StatefulWidget {
  final String id;
  final String day;
  final String starttime;
  final String endtime;
  final bool isClosed;
  const UpdateHourScreen({
    super.key,
    required this.id,
    required this.day,
    required this.endtime,
    required this.starttime,
    required this.isClosed,
  });

  @override
  State<UpdateHourScreen> createState() => _UpdateHourScreenState();
}

class _UpdateHourScreenState extends State<UpdateHourScreen> {
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
  bool isClosed = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  void _init() {
    setState(() {
      day = widget.day;
      start.text = widget.starttime;
      endControl.text = widget.endtime;
      isClosed = widget.isClosed;
    });
  }

  void updateHour() async {
    if (day.isEmpty || start.text.isEmpty || endControl.text.isEmpty) {
      return showErrorToast('Please fill all form');
    }

    try {
      setState(() {
        isLoading = true;
      });
      bool res = await DatabaseService.updatehour(
        id: widget.id,
        day: day,
        start: start.text,
        endHour: endControl.text,
        dayIndex: days.indexOf(day),
        closed: isClosed,
      );

      if (res) {
        showToast('Hour updated successfully');
        setState(() {
          isLoading = false;
        });
        Get.back();
      } else {
        showErrorToast('Error updating hour');
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

  String formatTimeOfDay(TimeOfDay timeOfDay) {
    final hours = timeOfDay.hourOfPeriod == 0 ? 12 : timeOfDay.hourOfPeriod;
    final minutes = timeOfDay.minute.toString().padLeft(2, '0');
    final period = timeOfDay.period == DayPeriod.am ? 'AM' : 'PM';

    return '$hours:$minutes $period';
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
                            Row(
                              children: [
                                Text(
                                  'Closed Day',
                                  style: textStyle14,
                                ),
                                const SizedBoxW10(),
                                CupertinoSwitch(
                                  value: isClosed,
                                  activeColor: red,
                                  onChanged: (value) {
                                    setState(() {
                                      isClosed = value;
                                    });
                                  },
                                )
                              ],
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
                                          updateHour();
                                        },
                                        text: 'Update Hour',
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
