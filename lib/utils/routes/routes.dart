import 'package:redesprou_boilerplate_name/ui/courses/courses_screen.dart';
import 'package:redesprou_boilerplate_name/ui/credit/credit_screen.dart';
import 'package:redesprou_boilerplate_name/ui/dashboard/dashboard.dart';
import 'package:redesprou_boilerplate_name/ui/home/home.dart';
import 'package:redesprou_boilerplate_name/ui/insurance/insurance_screen.dart';
import 'package:redesprou_boilerplate_name/ui/login/login.dart';
import 'package:redesprou_boilerplate_name/ui/notification/notification_screen.dart';
import 'package:redesprou_boilerplate_name/ui/profile/profile_presentation.dart';
import 'package:redesprou_boilerplate_name/ui/profile/profile_resume_screen.dart';
import 'package:redesprou_boilerplate_name/ui/profile/profile_step_one_screen.dart';
import 'package:redesprou_boilerplate_name/ui/profile/profile_step_two_screen.dart';
import 'package:redesprou_boilerplate_name/ui/services/list/service_list.dart';
import 'package:redesprou_boilerplate_name/ui/services/service_presentation.dart';
import 'package:redesprou_boilerplate_name/ui/services/service_step_five.dart';
import 'package:redesprou_boilerplate_name/ui/services/service_step_four.dart';
import 'package:redesprou_boilerplate_name/ui/services/service_step_one.dart';
import 'package:redesprou_boilerplate_name/ui/services/service_step_three.dart';
import 'package:redesprou_boilerplate_name/ui/services/service_step_two.dart';
import 'package:redesprou_boilerplate_name/ui/signup/sign_up.dart';
import 'package:redesprou_boilerplate_name/ui/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:redesprou_boilerplate_name/ui/web_view_example.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String signup = '/signup';
  static const String dashboard = '/dashboard';

  static const String profilePresentation = '/profilepresentation';
  static const String profileStepOne = '/profileone';
  static const String profileStepTwo = '/profiletwo';
  static const String profileResume = '/profileresume';

  static const String servicePresentation = '/servicepresentation';
  static const String serviceStepOne = '/serviceone';
  static const String serviceStepTwo = '/servicetwo';
  static const String serviceStepThree = '/servicethree';
  static const String serviceStepFour = '/servicefour';
  static const String serviceStepFive = '/servicefive';
  static const String serviceResume = '/serviceresume';
  static const String serviceList = '/services';

  static const String freeCourses = '/freecourses';

  static const String notifications = "/notifications";

  static const String webViewExample = "/webviewexample";
  static const String insurance = "/insurance";
  static const String credit = "/credit";

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    login: (BuildContext context) => LoginScreen(),
    home: (BuildContext context) => HomeScreen(),
    signup: (BuildContext context) => SignUpScreen(),
    dashboard: (BuildContext context) => DashboardScreen(),
    profileResume: (BuildContext context) => ProfileResumeScreen(),
    profilePresentation: (BuildContext context) => ProfilePresentation(),
    profileStepOne: (BuildContext context) => ProfileStepOne(),
    profileStepTwo: (BuildContext context) => ProfileStepTwoScreen(),
    servicePresentation: (BuildContext context) => ServicePresentation(),
    serviceStepOne: (BuildContext context) => ServiceStepOneScreen(),
    serviceStepTwo: (BuildContext context) => ServiceStepTwoScreen(),
    serviceStepThree: (BuildContext context) => ServiceStepThreeScreen(),
    serviceStepFour: (BuildContext context) => ServiceStepFourScreen(),
    serviceStepFive: (BuildContext context) => ServiceStepFiveScreen(),
    serviceList: (BuildContext context) => ServiceListScreen(),
    freeCourses: (BuildContext context) => CoursesScreen(),
    notifications: (BuildContext context) => NotificationScreen(),
    webViewExample: (BuildContext context) => WebViewExample(),
    insurance: (BuildContext context) => InsuranceScreen(),
    credit: (BuildContext context) => CreditScreen(),
  };
}
