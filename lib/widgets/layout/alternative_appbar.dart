import 'package:flutter/material.dart';
import 'package:redesprou_boilerplate_name/constants/colors.dart';
import 'package:badges/badges.dart';

class AlternativeAppBar extends StatelessWidget {
  final bool showNotifications;
  final int badgeCount;
  const AlternativeAppBar({Key? key, this.showNotifications = false, this.badgeCount = 0}) : super(key: key);

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: const Color(0xFFf4f3f9),
      iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      actions: [
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Image.asset('assets/icons/ic_appicon.png', height: 100),
        ),
        if (showNotifications) _buildNotificationBell(context)
      ],
    );
  }

  GestureDetector _buildNotificationBell(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, top: 6, bottom: 6, right: 25),
        child: Container(
            height: 20,
            width: 20,
            child: Badge(
              showBadge: badgeCount > 0,
              badgeContent: Text(
                "$badgeCount",
                style: TextStyle(color: Colors.white),
              ),
              badgeColor: AppColors.purple[500]!,
              child: Image.asset('assets/icons/ic_notificacoes.png'),
            )),
      ),
    );
  }
}
