import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:redesprou_boilerplate_name/constants/colors.dart';

class TextFieldWidget extends StatelessWidget {
  final String? hint;
  final String? errorText;
  final bool isObscure;
  final bool isIcon;
  final TextInputType? inputType;
  final TextEditingController textController;
  final EdgeInsets padding;
  final Color hintColor;
  final FocusNode? focusNode;
  final ValueChanged? onFieldSubmitted;
  final ValueChanged? onChanged;
  final bool autoFocus;
  final TextInputAction? inputAction;
  final TextInputFormatter? inputFormatter;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextFormField(
        controller: textController,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        autofocus: autoFocus,
        textInputAction: inputAction,
        obscureText: this.isObscure,
        maxLength: maxLength,
        keyboardType: this.inputType,
        minLines: minLines,
        maxLines: maxLines,
        inputFormatters: inputFormatter != null ? [inputFormatter!] : [],
        style: TextStyle(color: AppColors.textInputColor),
        decoration: InputDecoration(
          hintText: this.hint,
          hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(color: hintColor),
          errorText: errorText,
          counterText: '',
          fillColor: Color(0xFFF3F3F9),
          filled: true,
          disabledBorder: InputBorder.none,
          border: InputBorder.none,
        ),
      ),
    );
  }

  const TextFieldWidget({
    Key? key,
    this.hint,
    required this.errorText,
    this.isObscure = false,
    this.isIcon = true,
    this.inputType,
    required this.textController,
    this.padding = const EdgeInsets.all(0),
    this.hintColor = Colors.grey,
    this.focusNode,
    this.onFieldSubmitted,
    this.onChanged,
    this.autoFocus = false,
    this.inputAction,
    this.inputFormatter,
    this.minLines,
    this.maxLines = 1,
    this.maxLength = 50,
  }) : super(key: key);
}
