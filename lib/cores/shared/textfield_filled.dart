import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:emptychair/cores/shared/colors.dart';

class CustomTextFieldFilled extends StatefulWidget {
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
  const CustomTextFieldFilled({
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
  CustomTextFieldFilledState createState() => CustomTextFieldFilledState();
}

class CustomTextFieldFilledState extends State<CustomTextFieldFilled> {
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
      style: GoogleFonts.beVietnamPro(),
      cursorColor: primary,
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        errorBorder: InputBorder.none,
        hintText: widget.hintText,
        isDense: true,
        focusColor: primary,
        filled: true,
        fillColor: const Color(0xff650A37),
        hintStyle: GoogleFonts.beVietnamPro(
            fontSize: 14, color: const Color(0xffA0A1A9)),
        contentPadding: widget.padding ?? const EdgeInsets.all(10),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 20),
          borderSide: const BorderSide(color: Color(0xff650A37)),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 20),
          borderSide: const BorderSide(color: Color(0xff650A37)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 20),
          borderSide: const BorderSide(color: Color(0xff650A37)),
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
