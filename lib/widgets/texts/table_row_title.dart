import 'package:flutter/material.dart';

class TableRowTitle extends StatelessWidget {
  final String title;
  const TableRowTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 16,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}
