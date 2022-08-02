import 'package:flutter/material.dart';

import 'package:redesprou_boilerplate_name/utils/asset_utils.dart';
import 'package:redesprou_boilerplate_name/widgets/buttons/dashboard_button.dart';

class AddPhotoButton extends StatelessWidget {
  final String iconName;
  final String label;
  final VoidCallback onTap;

  const AddPhotoButton({
    Key? key,
    required this.iconName,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 30),
      child: DashboardButton(
        image: assetIcon(name: iconName),
        label: label,
        size: 150,
        onTap: onTap,
      ),
    );
  }
}
