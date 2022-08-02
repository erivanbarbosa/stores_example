import 'package:flutter/material.dart';

class GenericCircularProgressIndicator extends StatelessWidget {
  final double? value;
  final Color? color;

  GenericCircularProgressIndicator({
    this.value,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: EdgeInsets.all(0),
      child: _buildCircularProgressIndicator(),
    ));
  }

  CircularProgressIndicator _buildCircularProgressIndicator() {
    return CircularProgressIndicator(
      value: this.value,
      valueColor: AlwaysStoppedAnimation(this.color),
    );
  }
}
