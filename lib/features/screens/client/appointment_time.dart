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
// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AppointmentTimeScreen extends StatefulWidget {
  const AppointmentTimeScreen({super.key});

  @override
  State<AppointmentTimeScreen> createState() => _AppointmentTimeScreenState();
}

class _AppointmentTimeScreenState extends State<AppointmentTimeScreen> {
  // var maskFormatter = MaskTextInputFormatter(
  //     mask: '##/##/####', type: MaskAutoCompletionType.lazy);
  final f = DateFormat.yMMMMd();
  DateTime? selectedDate;
  TextEditingController dateController = TextEditingController();
  String time = '';
  String name = '';
  String barberId = '';
  String barberName = '';
  String type = '';
  bool isLoading = false;
  final List<String> times = <String>[
    '9am',
    '9:30am',
    '10am',
    '10:30am',
    '11am',
    '11:30am',
    '12pm',
    '12:30pm',
    '1pm',
    '1:30pm',
    '2pm',
    '2:30pm',
    '3pm',
    '3:30pm',
    '4pm',
    '4:30pm',
    '5pm',
    '5:30pm',
    '6pm',
    '6:30pm',
    '7pm',
    '7:30pm',
    '8pm',
  ];
  @override
  void initState() {
    super.initState();
    // print('name ' + Get.arguments['name']);
    setState(() {
      name = Get.arguments['name'];
      barberId = Get.arguments['barberId'];
      type = Get.arguments['type'];
      barberName = Get.arguments['barberName'];
    });
  }

  void addQueue() async {
    // if (dateController.text.isEmpty) {
    //   return showErrorToast('Please enter date')
    // }
    if (time == '') {
      return showErrorToast('Please select time');
    }
    try {
      setState(() {
        isLoading = true;
      });
      // print(dateController.text);

      Map<String, dynamic> data = {
        'barberName': barberName,
        'barberId': barberId,
        'type': type,
        'clientName': name,
        'createdAt': Timestamp.now(),
        'appointmentDate': Timestamp.now(),
        'appointmentTime': time,
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
                          // Expanded(
                          //   child: InkWell(
                          //     onTap: () {
                          //       showDatePicker(
                          //         context: context,
                          //         lastDate: DateTime(2068),
                          //         firstDate: DateTime(2000),
                          //         initialDate: DateTime.now(),
                          //         helpText: "Select your date",
                          //         initialEntryMode:
                          //             DatePickerEntryMode.calendarOnly,
                          //         builder: (context, child) {
                          //           return Theme(
                          //               data: ThemeData.light().copyWith(
                          //                 primaryColor: red,
                          //                 backgroundColor: red,
                          //                 primaryColorLight: red,
                          //                 colorScheme: const ColorScheme.light(
                          //                   primary: red,
                          //                 ),
                          //               ),
                          //               child: child!);
                          //         },
                          //       ).then((date) {
                          //         if (date != null) {
                          //           setState(() {
                          //             selectedDate = date;
                          //             dateController.text = f.format(date);
                          //           });
                          //         }
                          //       });
                          //     },
                          //     child: TextFormField(
                          //       // inputFormatters: [maskFormatter],
                          //       controller: dateController,
                          //       keyboardType: TextInputType.number,
                          //       enabled: false,
                          //       decoration: InputDecoration(
                          //         hintText: "Pick Date",
                          //         hintStyle: textStyle14,
                          //       ),
                          //     ),
                          //   ),
                          // ),

                          // const SizedBoxW20(),
                          Expanded(
                            child: DropdownButtonFormField<dynamic>(
                              onChanged: (dynamic value) {
                                setState(() {
                                  time = value;
                                });
                              },
                              hint: const Text('Select Time'),
                              style: textStyle14.copyWith(
                                color: black,
                                fontWeight: FontWeight.bold,
                              ),
                              value: time.isNotEmpty ? time : null,
                              items: times.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,
                                      overflow: TextOverflow.clip,
                                      textAlign: TextAlign.center,
                                      style: textStyle14.copyWith(
                                        color: black,
                                        fontWeight: FontWeight.bold,
                                      )),
                                );
                              }).toList(),
                              icon: const Icon(
                                Icons.keyboard_arrow_down_sharp,
                                color: black,
                                size: 14,
                              ),
                              iconSize: 14,
                              decoration: InputDecoration(
                                hintText: 'Time',
                                isDense: true,
                                hintStyle: textStyle8.copyWith(
                                  color: black,
                                  fontWeight: FontWeight.bold,
                                ),
                                border: noborder,
                                focusedBorder: noborder,
                                enabledBorder: noborder,
                                errorBorder: noborder,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
                              ),
                            ),
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
                            onPressed: () {
                              Get.toNamed(AppPages.signIn);
                            },
                            text: 'Home',
                            textColor: white,
                            bgColor: green,
                          ),
                        ),
                        isLoading
                            ? const Center(
                                child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: primary,
                                    )),
                              )
                            : SizedBox(
                                width: 150,
                                child: CustomButton(
                                  onPressed: () {
                                    addQueue();
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
