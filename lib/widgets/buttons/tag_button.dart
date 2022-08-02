import 'package:flutter/material.dart';

class TagButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const TagButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      margin: EdgeInsets.only(right: 5),
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.only(left: 10, top: 0, bottom: 0),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
          IconButton(
            padding: EdgeInsets.all(0),
            onPressed: onTap,
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
