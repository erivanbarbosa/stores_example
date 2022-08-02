import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatelessWidget {
  final Function(DateTime) onDateSelected;
  final DateTime? initialValue;
  final DateFormat? dateFormat;

  const CustomDatePicker({Key? key, required this.onDateSelected, this.initialValue, this.dateFormat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DateTimeFormField(
      initialValue: initialValue,
      dateFormat: dateFormat ?? DateFormat("dd/MM/yyyy"),
      // dateFormat: dateFormat ?? DateFormat("MM/yyyy"),
      decoration: const InputDecoration(
        filled: true,
        fillColor: Color(0xFFF3F3F9),
        hintText: "DD/MM/AAAA",
        hintStyle: TextStyle(color: Colors.grey),
        errorStyle: TextStyle(color: Colors.redAccent),
        border: InputBorder.none,
      ),
      mode: DateTimeFieldPickerMode.date,
      autovalidateMode: AutovalidateMode.always,
      validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
      onDateSelected: onDateSelected,
    );
  }
}
