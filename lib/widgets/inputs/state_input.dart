import 'package:flutter/material.dart';
import 'package:redesprou_boilerplate_name/utils/locale/app_localization.dart';
import 'package:redesprou_boilerplate_name/widgets/inputs/generic_dropdown_input.dart';

class StateInput extends StatelessWidget {
  final int? value;
  final List<DropdownMenuItem<int>> states;
  final ValueChanged onChanged;

  const StateInput({
    Key? key,
    this.value,
    required this.states,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GenericDropdownInput<int>(
      hint: AppLocalizations.of(context).translate('state'),
      value: value,
      items: states,
      onChanged: onChanged,
    );
  }
}
