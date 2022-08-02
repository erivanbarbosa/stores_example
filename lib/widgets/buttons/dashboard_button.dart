import 'package:flutter/material.dart';

class DashboardButton extends StatelessWidget {
  final String image;
  final String label;
  final VoidCallback onTap;
  final double size;
  final bool networkImage;

  const DashboardButton({
    Key? key,
    required this.image,
    required this.label,
    required this.onTap,
    this.size = 110,
    this.networkImage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: _buildInkWell(),
    );
  }

  InkWell _buildInkWell() {
    return InkWell(
      onTap: onTap,
      child: _buildContainer(),
    );
  }

  Container _buildContainer() {
    return Container(
      width: size,
      height: size,
      child: _buildColumn(),
    );
  }

  Column _buildColumn() {
    return Column(children: [
      _buildIcon(),
      _buildLabel(),
    ]);
  }

  Expanded _buildIcon() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(14),
        child: networkImage ? Image.network(image) : Image(image: AssetImage(image), height: 50),
      ),
    );
  }

  Container _buildLabel() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Text(label),
    );
  }
}
