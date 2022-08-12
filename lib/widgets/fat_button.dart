import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final Color? borderColor;
  final VoidCallback? onPressed;

  const MainButton({
    Key? key,
    required this.buttonText,
    required this.buttonColor,
    this.textColor = Colors.white,
    this.borderColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      child: Container(
        width: double.infinity,
          padding: EdgeInsets.all(16),
          child: Text(
            buttonText.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(color: textColor, fontSize: 16),
          )),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: buttonColor,
        elevation: 0,
        side: borderColor != null ? BorderSide(width: 2.0, color: textColor) : null
      ),
    );
  }
}
