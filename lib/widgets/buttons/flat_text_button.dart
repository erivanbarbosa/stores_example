import 'package:flutter/material.dart';

class FlatTextButton extends StatelessWidget {
  final Color color;

  final String text;

  const FlatTextButton({ Key? key, this.text = "", this.color = Colors.black }) : super(key: key);

  @override
  Widget build(BuildContext context) {
        return Align(
      alignment: FractionalOffset.center,
      child: FlatButton(
        padding: EdgeInsets.all(0.0),
        child: Text(text,
          style: TextStyle(fontSize: 16, color: color),
        ),
        onPressed: () {},
      ),
    );
  }
}