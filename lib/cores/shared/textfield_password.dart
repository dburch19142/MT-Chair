import 'package:emptychair/cores/shared/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFieldPassword extends StatefulWidget {
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final bool obsecure;
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
  const CustomTextFieldPassword({
    Key? key,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.visiblePassword,
    required this.obsecure,
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
  _CustomTextFieldPasswordState createState() =>
      _CustomTextFieldPasswordState();
}

class _CustomTextFieldPasswordState extends State<CustomTextFieldPassword> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enabled,
      maxLength: widget.maxLength,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingCompleted,
      controller: widget.controller,
      validator: widget.validator,
      style: const TextStyle(),
      obscureText: widget.obsecure,
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
