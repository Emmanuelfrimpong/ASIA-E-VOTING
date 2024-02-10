

import 'package:flutter/material.dart';
import 'package:frontend/utils/styles.dart';


class CustomDropDown extends StatelessWidget {
  const CustomDropDown(
      {super.key,
      this.value,
      required this.items,
      this.validator,
      this.hintText,
      this.onChanged,
      this.radius,
      required this.color,
      this.onSaved,
      this.label,
      this.prefixIcon,
      this.iconData});

  final dynamic value;
  final List<DropdownMenuItem> items;
  final String? Function(dynamic)? validator;
  final String? hintText;
  final String? label;
  final Function(dynamic)? onChanged;
  final Function(dynamic)? onSaved;
  final double? radius;
  final Color color;
  final IconData? iconData;
  final IconData? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
        child: DropdownButtonFormField(
      borderRadius: BorderRadius.circular(5),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 5),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 5),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
        fillColor: color,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 5),
          borderSide: const BorderSide(color: primaryColor),
        ),
        prefixIconColor: primaryColor,
        suffixIconColor: primaryColor,
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: primaryColor,
              )
            : null,
        contentPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
        labelStyle: getTextStyle(
            color: Colors.black45, weight: FontWeight.bold, size: 14),
        labelText: label,
        hintText: hintText,
        focusColor: primaryColor,
        iconColor: Colors.grey,
        hintStyle: getTextStyle(
            color: Colors.black45, weight: FontWeight.bold, size: 14),
      ),
      onChanged: onChanged,
      onSaved: onSaved,
      dropdownColor: Colors.white,
      items: items,
      validator: validator,
      value: value,
      isExpanded: true,
      icon: Icon(
        iconData ?? Icons.arrow_drop_down,
        color: primaryColor,
      ),
    ));
  }
}
