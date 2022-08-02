import 'package:flutter/material.dart';

class TitleMessage extends StatelessWidget {
  final String title;
  const TitleMessage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 24,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
