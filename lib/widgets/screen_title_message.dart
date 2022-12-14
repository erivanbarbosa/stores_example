import 'package:flutter/material.dart';

class ScreenTitleMessage extends StatelessWidget {
  final String message;
  const ScreenTitleMessage({Key? key, required this.message }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(message,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 24,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
