import 'package:flutter/material.dart';

class AppIconWidget extends StatelessWidget {
  final image;
  final double iconSize;

  const AppIconWidget({
    Key? key,
    this.image,
    this.iconSize = 0.15
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //getting screen size
    var size = MediaQuery.of(context).size;

    //calculating container width
    double imageSize;
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      imageSize = (size.width * iconSize);
    } else {
      imageSize = (size.height * iconSize);
    }

    return Image.asset(
      image,
      height: imageSize,
    );
  }
}
