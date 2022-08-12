import 'package:redesprou_boilerplate_name/stores/error/error_store.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'theme_store.g.dart';

class ThemeStore = _ThemeStore with _$ThemeStore;

abstract class _ThemeStore with Store {
  final String TAG = "_ThemeStore";

  // repository instance

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // store variables:-----------------------------------------------------------
  @observable
  bool _darkMode = false;


  // getters:-------------------------------------------------------------------
  bool get darkMode => _darkMode;

  // constructor:---------------------------------------------------------------
  _ThemeStore() {
    init();
  }

  // actions:-------------------------------------------------------------------
  @action
  Future changeBrightnessToDark(bool value) async {
    _darkMode = value;
  }

  // general methods:-----------------------------------------------------------
  Future init() async {
    _darkMode = false;
  }

  bool isPlatformDark(BuildContext context) =>
      MediaQuery.platformBrightnessOf(context) == Brightness.dark;

  // dispose:-------------------------------------------------------------------
  @override
  dispose() {

  }
}
