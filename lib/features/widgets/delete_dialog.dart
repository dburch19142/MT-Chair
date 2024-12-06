import 'package:flutter/material.dart';
import 'package:emptychair/cores/constants/constants.dart';
import 'package:emptychair/cores/shared/colors.dart';
import 'package:emptychair/cores/shared/size_boxes.dart';
import 'package:emptychair/cores/shared/style.dart';

Widget deletDialog(BuildContext context,
    {required Function() onDelete,
    required Function() onCancel,
    required bool deleteAll}) {
  return AlertDialog(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0))),
    content: SizedBox(
      width: width(context) * .8,
      // height: height(context) * .4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.delete,
            size: 40,
            color: red,
          ),
          const SizedBoxH10(),
          Text(
            deleteAll
                ? 'Are you sure you want to delete all barbers?'
                : 'Are you sure you want to delete \nthis barber?',
            textAlign: TextAlign.center,
            style: textStyle12,
          ),
          const SizedBoxH10(),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: onCancel,
                child: Text(
                  'Go Back',
                  style: textStyle14.copyWith(
                    fontWeight: FontWeight.bold,
                    color: black,
                  ),
                ),
              ),
              TextButton(
                onPressed: onDelete,
                child: Text(
                  'Delete',
                  style: textStyle14.copyWith(
                    fontWeight: FontWeight.bold,
                    color: red,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
