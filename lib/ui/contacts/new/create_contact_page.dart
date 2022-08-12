import 'dart:async';

import 'package:flutter/material.dart';
import 'package:redesprou_boilerplate_name/di/components/service_locator.dart';
import 'package:redesprou_boilerplate_name/stores/contact/contact_store.dart';
import 'package:redesprou_boilerplate_name/ui/contacts/new/partial/contact_birth_date_partial_page.dart';
import 'package:redesprou_boilerplate_name/ui/contacts/new/partial/contact_email_partial_page.dart';
import 'package:redesprou_boilerplate_name/ui/contacts/new/partial/contact_name_partial_page.dart';
import 'package:redesprou_boilerplate_name/ui/contacts/new/partial/contact_phone_partial_page.dart';
import 'package:redesprou_boilerplate_name/ui/contacts/new/partial/save_contact_partial_page.dart';
import 'package:redesprou_boilerplate_name/widgets/default_app_screen.dart';
import 'package:redesprou_boilerplate_name/widgets/layout/page_controller.dart';

class CreateContactPage extends StatefulWidget {
  const CreateContactPage({Key? key}) : super(key: key);

  @override
  _CreateContactPageState createState() => _CreateContactPageState();
}

class _CreateContactPageState extends State<CreateContactPage> {
  final _pageViewKey = UniqueKey();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late PageViewController _pageViewController;

  @override
  void initState() {
    _pageViewController = PageViewController(context);
    super.initState();
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => _previousPage(),
        child: DefaultAppScreen(
          screenTitle: "Novo Contato",
          screenBody: [
            Container(
              height: 400,
              child: PageView(
                key: _pageViewKey,
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageViewController.get,
                children: [
                  ContactNamePartialPage(
                    onSubmit: () {
                      _pageViewController.nextPage();
                    },
                  ),
                  ContactBirthDatePartialPage(
                    onSubmit: () {
                      _pageViewController.nextPage();
                    },
                  ),
                  ContactPhonePartialPage(
                    onSubmit: () {
                      _pageViewController.nextPage();
                    },
                  ),
                  ContactEmailPartialPage(
                    onSubmit: () {
                      _pageViewController.nextPage();
                    },
                  ),
                  SaveContactPartialPage(
                    onSubmit: () {
                      _pageViewController.nextPage();
                    },
                  )
                ],
              ),
            )
          ],
        ));
  }

  Future<bool> _previousPage() {
    FocusScope.of(context).unfocus();
    return _pageViewController.previousPage();
  }
}
