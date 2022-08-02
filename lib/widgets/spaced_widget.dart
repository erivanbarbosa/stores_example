import 'package:flutter/material.dart';

class SpacedWidget extends StatelessWidget {
  final Widget widget;
  final bool spaceBelow;
  final double spaceHeight = 15;

  const SpacedWidget(this.widget, {Key? key, this.spaceBelow = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: spaceHeight),
        widget,
        spaceBelow ?  SizedBox(height: spaceHeight) : Container()
      ],
    );
  }
}
