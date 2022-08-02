import 'package:flutter/material.dart';
import 'package:redesprou_boilerplate_name/data/sharedpref/constants/preferences.dart';
import 'package:redesprou_boilerplate_name/utils/navigation_utils.dart';
import 'package:redesprou_boilerplate_name/utils/routes/routes.dart';
import 'package:redesprou_boilerplate_name/utils/translate_utils.dart';
import 'package:redesprou_boilerplate_name/widgets/layout/alternative_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlternativeAppScreen extends StatelessWidget {
  Widget screenBody;
  final bool showNotifications;
  final int badgeCount;

  AlternativeAppScreen({Key? key, required this.screenBody, this.showNotifications = false, this.badgeCount = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      drawer: _buildDrawer(context),
    );
  }

  PreferredSize _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(50),
      child: AlternativeAppBar(
        showNotifications: showNotifications,
        badgeCount: badgeCount,
      ),
    );
  }

  _buildBody() {
    return Stack(
      children: [screenBody],
    );
  }

  _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Text(
              'Gigwks',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          ListTile(
            title: Text(translate(context, "Perfil de Usuário")),
            onTap: () {
              pushNamed(context, Routes.profilePresentation);
            },
          ),
          ListTile(
            title: Text(translate(context, "Adicionar Novo Serviço")),
            onTap: () {
              pushNamed(context, Routes.servicePresentation);
            },
          ),
          ListTile(
            title: Text(translate(context, "Serviços")),
            onTap: () {
              pushNamed(context, Routes.serviceList);
            },
          ),
          IconButton(
            onPressed: () {
              SharedPreferences.getInstance().then((preference) {
                preference.setBool(Preferences.is_logged_in, false);
                Navigator.of(context).pushReplacementNamed(Routes.login);
              });
            },
            icon: Icon(Icons.power_settings_new),
          )
        ],
      ),
    );
  }
}
