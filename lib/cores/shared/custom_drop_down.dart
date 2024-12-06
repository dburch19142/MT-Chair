import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:emptychair/cores/shared/colors.dart';
import 'package:emptychair/cores/shared/style.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  final List<String> items;
  final String val;
  final String hintText;
  final Function(String?) onChanged;
  const CustomDropDown({
    super.key,
    required this.items,
    required this.val,
    required this.hintText,
    required this.onChanged,
  });

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      onChanged: widget.onChanged,
      hint: Text(
        widget.hintText,
        style: textStyle14.copyWith(color: altoGrey),
      ),
      value: widget.val.isNotEmpty ? widget.val : null,
      validator: (value) => value == null ? 'Field required' : null,
      isDense: true,
      style: textStyle14,
      items: widget.items.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem(
          value: value,
          child: Text(
            value,
            overflow: TextOverflow.clip,
            style: textStyle14.copyWith(
              color: black,
            ),
          ),
        );
      }).toList(),
      decoration: InputDecoration(
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: red, width: 1.5),
        ),
        hintText: widget.hintText,
        isDense: true,
        hintStyle: textStyle14.copyWith(
          color: altoGrey,
          fontSize: 14,
        ),
        contentPadding: const EdgeInsets.only(
          right: 10,
          top: 10,
          bottom: 10,
        ),
        filled: true,
        fillColor: white,
        border: outlineInputBorder.copyWith(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: altoGrey,
          ),
        ),
        enabledBorder: outlineInputBorder.copyWith(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: altoGrey,
          ),
        ),
        focusedBorder: outlineInputBorder.copyWith(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: altoGrey,
          ),
        ),
      ),
    );
  }
}
