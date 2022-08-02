import 'package:flutter/material.dart';
import 'package:redesprou_boilerplate_name/utils/locale/app_localization.dart';

String translate(context,String key) {
  return AppLocalizations.of(context).translate(key);
}