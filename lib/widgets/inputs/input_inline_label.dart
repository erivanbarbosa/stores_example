import 'package:flutter/material.dart';

class InputInlineLabel extends StatelessWidget {
  final String label;
  final double width;

  const InputInlineLabel({Key? key, required this.label, this.width = 100}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      width: width,
      child: Text(label),
    );
  }
}
