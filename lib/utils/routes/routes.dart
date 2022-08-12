import 'package:redesprou_boilerplate_name/ui/contacts/new/create_contact_page.dart';
import 'package:redesprou_boilerplate_name/ui/dashboard/dashboard.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  //static variables
  
  static const String splash = '/splash';
  static const String dashboard = '/dashboard';
  static const String new_contact = '/new-contact';

  static final routes = <String, WidgetBuilder>{
    dashboard: (BuildContext context) => DashboardScreen(),
    new_contact: (BuildContext context) => CreateContactPage()
  };
}
