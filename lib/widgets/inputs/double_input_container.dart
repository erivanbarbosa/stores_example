import 'package:flutter/material.dart';

class DoubleInputContainer extends StatelessWidget {
  final Widget firstWidget;
  final Widget secondWidget;
  final int firstWidgetFlex;
  final int secondWidgetFlex;

  const DoubleInputContainer({
    Key? key,
    required this.firstWidget,
    required this.secondWidget,
    required this.firstWidgetFlex,
    required this.secondWidgetFlex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: firstWidgetFlex,
            child: Container(
              width: 100,
              child: firstWidget,
            )),
        Container(
          width: 15,
        ),
        Expanded(
            flex: secondWidgetFlex,
            child: Container(
              width: 100,
              child: secondWidget,
            )),
      ],
    );
  }
}
