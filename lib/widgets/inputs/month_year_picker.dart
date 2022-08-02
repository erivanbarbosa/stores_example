import 'dart:async';

import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class MonthYearPicker extends StatelessWidget {
  final FutureOr Function(DateTime? value) onSelect;
  final DateTime? selectedDate;

  const MonthYearPicker({
    Key? key,
    required this.onSelect,
    this.selectedDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showMonthPicker(context),
      child: InputDecorator(
        decoration: const InputDecoration(
          filled: true,
          fillColor: Color(0xFFF3F3F9),
          hintText: "DD/MM/AAAA",
          hintStyle: TextStyle(color: Colors.grey),
          errorStyle: TextStyle(color: Colors.redAccent),
          border: InputBorder.none,
        ),
        child: Container(child: _buildText()),
      ),
    );
  }

  _showMonthPicker(context) {
    showMonthPicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: selectedDate ?? DateTime.now(),
      locale: Locale("pt"),
    ).then(this.onSelect);
  }

  Text _buildText() {
    return selectedDate != null ? _buildDateText() : _getHint();
  }

  _getHint() {
    return Text(
      "MM/AAAA",
      style: TextStyle(color: Colors.grey),
    );
  }

  _buildDateText() {
    int month = selectedDate!.month;
    int year = selectedDate!.year;
    String monthText = month >= 10 ? "$month" : "0$month";
    return Text("$monthText/$year");
  }
}
