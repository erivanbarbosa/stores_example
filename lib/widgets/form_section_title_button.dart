import 'package:flutter/material.dart';

import 'package:redesprou_boilerplate_name/widgets/form/form_section_title.dart';

class FormSectionTitleButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final double fontSize;
  final double bottom;

  const FormSectionTitleButton({Key? key, required this.title, required this.icon, required this.onTap, this.fontSize = 14, this.bottom = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        FormSectionTitle(
          title: title,
          alignment: TextAlign.center,
          top: 0,
          fontSize: fontSize,
          bottom: bottom,
        ),
        Container(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: onTap,
            icon: Icon(icon),
          ),
        ),
      ],
    );
  }
}
