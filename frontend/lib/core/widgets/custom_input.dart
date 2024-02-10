import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/utils/styles.dart';


class CustomTextFields extends ConsumerWidget {
  const CustomTextFields({
    super.key,
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.keyboardType,
    this.onChanged,
    this.onSaved,
    this.maxLines,
    this.hintText,
    this.radius,
    this.onTap,
    this.helperText,
    this.isCapitalized = false,
    this.isDigitOnly = false,
    this.min = 0,
    this.max = 999999,
    this.color = Colors.white,
    this.isReadOnly = false,
    this.validator,
    this.controller,
    this.isPhoneInput = false,
  });

  final String? label;
  final String? helperText;
  final String? hintText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final void Function()? onTap;
  final int? maxLines;
  final double? radius;
  final bool? isCapitalized;
  final bool? isDigitOnly;
  final bool? isReadOnly;
  final Color color;
  final int? max, min;
  final TextEditingController? controller;
  final bool? isPhoneInput;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      obscureText: obscureText ?? false,
      onTap: onTap,
      validator: validator,
      inputFormatters: [
        if (isCapitalized!) UpperCaseTextFormatter(),
        if (isDigitOnly ?? false)
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
        PreventDeleteFormatter(max!, min!),
      ],
      textCapitalization: isCapitalized!
          ? TextCapitalization.characters
          : TextCapitalization.none,
      style: getTextStyle(
          color: Colors.black, weight: FontWeight.bold, size: 16),
      onChanged: onChanged,
      onSaved: onSaved,
      maxLines: maxLines ?? 1,
      readOnly: isReadOnly ?? false,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 5),
          borderSide: const BorderSide(
            color: primaryColor,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 5),
          borderSide: const BorderSide(
            color: primaryColor,
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
        labelStyle: getTextStyle(
            color: Colors.black45, weight: FontWeight.w700, size: 16),
        labelText: label,
        hintText: hintText,
        focusColor: primaryColor,
        helperText: helperText,
        helperStyle: const TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.w500,
        ),
        iconColor: primaryColor,
        hintStyle: getTextStyle(
            color: Colors.black45, weight: FontWeight.w700, size: 16),
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                size: 18,
                color: primaryColor,
              )
            : null,
        suffixIcon: suffixIcon,
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (RegExp("[a-zA-Z,]").hasMatch(newValue.text)) {
      return TextEditingValue(
        text: newValue.text.toUpperCase(),
        selection: newValue.selection,
      );
    } else if (!RegExp(r'^[a-zA-Z0-9_\-=@+,\.;]+$').hasMatch(newValue.text)) {
      return newValue;
    }
    return oldValue;
  }
}

class PreventDeleteFormatter extends TextInputFormatter {
  final int max, min;

  PreventDeleteFormatter(this.max, this.min);
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > min - 1 && newValue.text.length < max + 1) {
      return newValue;
    }
    return oldValue;
  }
}
