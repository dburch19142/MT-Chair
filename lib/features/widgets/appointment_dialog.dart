import 'package:emptychair/cores/shared/button.dart';
import 'package:flutter/material.dart';
import 'package:emptychair/cores/constants/constants.dart';
import 'package:emptychair/cores/shared/colors.dart';
import 'package:emptychair/cores/shared/size_boxes.dart';
import 'package:emptychair/cores/shared/style.dart';
import 'package:hive/hive.dart';

Widget appointmentDialog(BuildContext context,
    {required Function() onNo,
    required Function() onYes,
    required bool isLoading}) {
  // String bg = Hive.box('mt-chair').get('bg', defaultValue: '');
  return AlertDialog(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0))),
    content: AppointmentWidget(
      onYes: onYes,
      onNo: onNo,
      isLoading: isLoading,
    ),
  );
}

class AppointmentWidget extends StatefulWidget {
  final Function() onNo;
  final Function() onYes;
  final bool isLoading;
  const AppointmentWidget({
    super.key,
    required this.onYes,
    required this.onNo,
    required this.isLoading,
  });

  @override
  State<AppointmentWidget> createState() => _AppointmentWidgetState();
}

class _AppointmentWidgetState extends State<AppointmentWidget> {
  @override
  Widget build(BuildContext context) {
    String logo = Hive.box('mt-chair').get('logo', defaultValue: '');
    return AlertDialog(
      content: SizedBox(
        width: width(context) * .8,
        // height: height(context) * .4,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  logo == ''
                      ? Image.asset(
                          'assets/images/logo.png',
                          width: width(context) / 3,
                        )
                      : Image.network(
                          logo,
                          width: width(context) / 3,
                        ),
                  const SizedBoxH20(),
                  Text(
                    'Do you  have an appointment? ',
                    style: textStyle14,
                  ),
                  const SizedBoxH20(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: width(context) * .2,
                        child: CustomButton(
                          onPressed: widget.onYes,
                          text: 'Yes',
                          textColor: white,
                          bgColor: const Color(0xff04FFFF).withOpacity(.5),
                        ),
                      ),
                      widget.isLoading
                          ? const SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator())
                          : SizedBox(
                              width: width(context) * .2,
                              child: CustomButton(
                                onPressed: widget.onNo,
                                text: 'No',
                                textColor: white,
                                bgColor: red,
                              ),
                            ),
                    ],
                  ),
                  const SizedBoxH40(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
