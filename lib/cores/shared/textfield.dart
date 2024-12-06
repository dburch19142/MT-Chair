import 'package:emptychair/cores/shared/style.dart';
import 'package:flutter/material.dart';
import 'package:emptychair/cores/shared/colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final bool? obsecure;
  final bool? readOnly;
  final VoidCallback? onTap;
  final VoidCallback? onEditingCompleted;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final bool? isMulti;
  final bool? autofocus;
  final bool? enabled;
  final String? errorText;
  final String? label;
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? minLine;
  final int? maxLength;
  final double? borderRadius;
  final EdgeInsets? padding;
  const CustomTextField({
    Key? key,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obsecure,
    this.onTap,
    this.isMulti = false,
    this.readOnly = false,
    this.autofocus = false,
    this.errorText,
    this.label,
    this.maxLength,
    required this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.enabled = true,
    this.onEditingCompleted,
    this.onChanged,
    this.minLine,
    this.borderRadius,
    this.padding,
  }) : super(key: key);

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enabled,
      maxLength: widget.maxLength,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingCompleted,
      controller: widget.controller,
      maxLines: null,
      minLines: widget.minLine,
      validator: widget.validator,
      style: textStyle14.copyWith(color: black),
      cursorColor: primary,
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
          borderSide: const BorderSide(color: red, width: 1.5),
        ),
        hintText: widget.hintText,
        isDense: true,
        focusColor: primary,
        hintStyle: const TextStyle(fontSize: 14, color: Color(0xffA0A1A9)),
        contentPadding: widget.padding ?? const EdgeInsets.all(14),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
          borderSide: const BorderSide(color: Color(0xFFA3A0A4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
          borderSide: const BorderSide(color: Color(0xFFA3A0A4)),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
          borderSide: const BorderSide(color: Color(0xFFA3A0A4)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
          borderSide: const BorderSide(color: Colors.blue, width: 1),
        ),
      ),
    );
  }
}

InputDecoration dropdownDecoration(String hint) {
  return InputDecoration(
    errorBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: warGrey, width: 1.5),
    ),
    hintText: hint,
    isDense: true,
    hintStyle: const TextStyle(fontSize: 14),
    enabledBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: warGrey),
    ),
    border: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: warGrey),
    ),
    focusedBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: warGrey, width: 3.5),
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 15,
      vertical: 15,
    ),
  );
}
