import 'package:flutter/material.dart';
import 'package:redesprou_boilerplate_name/widgets/layout/alternative_appbar.dart';

class AlternativeAppScreen extends StatelessWidget {
  Widget screenBody;
  final bool showNotifications;
  final int badgeCount;
  final FloatingActionButton floatingActionButton;

  AlternativeAppScreen({Key? key, required this.screenBody, this.showNotifications = false, this.badgeCount = 0, required this.floatingActionButton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
        drawer: _buildDrawer(context),
        floatingActionButton: this.floatingActionButton);
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
              'Teste',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          ListTile(title: Text("")),
        ],
      ),
    );
  }
}
