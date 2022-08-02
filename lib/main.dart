import 'dart:async';

//import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:get/get.dart';
import 'package:redesprou_boilerplate_name/firebase_service.dart';
import 'package:redesprou_boilerplate_name/stores/courses/course_store.dart';
import 'package:redesprou_boilerplate_name/stores/notification/notification_store.dart';
import 'package:redesprou_boilerplate_name/stores/service/service_list_store.dart';
import 'package:redesprou_boilerplate_name/stores/service/service_store.dart';
import 'package:redesprou_boilerplate_name/stores/webview/webview_store.dart';
import 'package:redesprou_boilerplate_name/ui/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'di/components/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  //Stetho.initialize();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  Get.put(NotificationStore());
  Get.put(ServiceStore());
  Get.put(CourseStore());
  Get.put(ServiceListStore());
  Get.put(WebviewStore());

  //await configureFirebase();
  await setPreferredOrientations();
  await setupLocator();
  return runZonedGuarded(() async {
    runApp(MyApp());
  }, (error, stack) {
    print(stack);
    print(error);
  });
}

Future<void> setPreferredOrientations() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
}
