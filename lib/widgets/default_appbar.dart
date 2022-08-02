import 'package:flutter/material.dart';
import 'package:redesprou_boilerplate_name/utils/locale/app_localization.dart';

class DefaultAppBar extends StatelessWidget {
  final String title;

  const DefaultAppBar({Key? key, this.title = ""}) : super(key: key);

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      title: _buildTitle(context),
      backgroundColor: Colors.white,
      leading: _buildLeading(context),
    );
  }

  Text _buildTitle(BuildContext context) {
    return Text(
      AppLocalizations.of(context).translate(title),
      textAlign: TextAlign.center,
      style: TextStyle(color: Theme.of(context).primaryColor),
    );
  }

  IconButton _buildLeading(BuildContext context) {
    return IconButton(
      icon: _buildBackIcon(context),
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  Icon _buildBackIcon(BuildContext context) {
    return Icon(
      Icons.chevron_left,
      color: Theme.of(context).primaryColor,
      size: 40,
    );
  }
}
