import 'package:flutter/material.dart';

import 'package:redesprou_boilerplate_name/constants/colors.dart';

class FormSectionTitle extends StatelessWidget {
  final double top;
  final double bottom;
  final String title;
  final TextAlign alignment;
  final double fontSize;
  const FormSectionTitle({Key? key, this.top = 40, this.bottom = 10, required this.title, this.alignment = TextAlign.left, this.fontSize = 14})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: top, bottom: bottom),
      child: Text(
        title,
        textAlign: alignment,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: AppColors.textColor,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
