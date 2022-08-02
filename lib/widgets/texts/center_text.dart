import 'package:flutter/material.dart';

class CenterText extends StatelessWidget {
  final double fontSize;
  final String text;
  const CenterText({Key? key, required this.text, this.fontSize = 14}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: fontSize),
    );
  }
}
