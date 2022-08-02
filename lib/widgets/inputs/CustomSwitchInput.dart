import 'package:flutter/material.dart';

class CustomSwitchInput extends StatelessWidget {
  final String label;
  final bool value;
  final Function(bool?) onChanged;

  const CustomSwitchInput({Key? key, required this.label, required this.value, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      contentPadding: EdgeInsets.all(0),
      title: Text(label),
      activeColor: Colors.blueAccent,
      value: value,
      onChanged: onChanged,
    );
  }
}
