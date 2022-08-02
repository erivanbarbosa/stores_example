import 'package:flutter/material.dart';
import 'package:redesprou_boilerplate_name/constants/colors.dart';

class GenericDropdownInput<T> extends StatelessWidget {
  final String? hint;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged? onChanged;

  const GenericDropdownInput({Key? key, this.onChanged, required this.value, this.hint, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: Color(0xFFF3F3F9)),
      child: DropdownButtonHideUnderline(
        child: Padding(
          padding: EdgeInsets.only(top: 0, left: 12, right: 16),
          child: DropdownButton<T>(
            isExpanded: true,
            hint: _buildHint(context),
            value: value,
            items: items,
            onChanged: onChanged,
            style: TextStyle(color: AppColors.textInputColor),
          ),
        ),
      ),
    );
  }

  Text _buildHint(BuildContext context) {
    return Text(
      hint ?? "",
      style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey),
    );
  }
}
