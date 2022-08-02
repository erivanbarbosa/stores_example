import 'package:flutter/material.dart';

class CustomCheckBoxInput extends StatelessWidget {
  final String label;
  final bool value;
  final Function(bool?) onChanged;

  const CustomCheckBoxInput({Key? key, required this.label, required this.value, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.all(0),
      title: Text(label),
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Colors.blueAccent,
      value: value,
      onChanged: onChanged,
    );
  }
}
