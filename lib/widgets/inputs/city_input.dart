import 'package:flutter/material.dart';
import 'package:redesprou_boilerplate_name/utils/locale/app_localization.dart';
import 'package:redesprou_boilerplate_name/widgets/inputs/generic_dropdown_input.dart';

class CityInput extends StatelessWidget {
  final int? value;
  final List<DropdownMenuItem<int>> cities;
  final ValueChanged onChanged;

  const CityInput({
    Key? key,
    this.value,
    required this.cities,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GenericDropdownInput<int>(
      hint: AppLocalizations.of(context).translate('city'),
      value: value,
      items: cities,
      onChanged: onChanged,
    );
  }
}
