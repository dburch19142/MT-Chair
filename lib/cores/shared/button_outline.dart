import 'package:flutter/material.dart';
import 'package:emptychair/cores/shared/colors.dart';
import 'package:emptychair/cores/shared/style.dart';

class CustomButtonOutline extends StatelessWidget {
  final String? text;
  final Widget? child;
  final double? hPadding;
  final double? vPadding;
  final double? size;
  final double? borderRadius;
  final Color? bgColor;
  final Color? textColor;
  final Function() onPressed;

  const CustomButtonOutline({
    Key? key,
    this.text,
    this.child,
    this.hPadding,
    this.vPadding,
    this.size,
    this.borderRadius,
    this.bgColor,
    this.textColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: size ?? MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: hPadding ?? 10,
          vertical: vPadding ?? 15,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 25)),
          border: Border.all(
            color: bgColor ?? black,
          ),
        ),
        child: Center(
          child: child ??
              Text(
                text ?? 'Click Here',
                textAlign: TextAlign.center,
                style: textStyle16.copyWith(
                  color: textColor ?? black,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
    );
  }
}
