import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:redesprou_boilerplate_name/stores/contact/contact_store.dart';
import 'package:redesprou_boilerplate_name/ui/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'di/components/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  _initStores();

  await setPreferredOrientations();
  await setupLocator();
  return runZonedGuarded(() async {
    runApp(MyApp());
  }, (error, stack) {
    print(stack);
    print(error);
  });
}

_initStores() {
  final getIt = GetIt.instance;
  getIt.registerSingleton<ContactStore>(ContactStore());
}

Future<void> setPreferredOrientations() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
}
