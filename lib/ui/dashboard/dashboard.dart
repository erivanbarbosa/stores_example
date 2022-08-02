import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:redesprou_boilerplate_name/stores/notification/notification_store.dart';
import 'package:redesprou_boilerplate_name/utils/asset_utils.dart';
import 'package:redesprou_boilerplate_name/utils/navigation_utils.dart';
import 'package:redesprou_boilerplate_name/utils/routes/routes.dart';
import 'package:redesprou_boilerplate_name/utils/translate_utils.dart';
import 'package:redesprou_boilerplate_name/widgets/buttons/dashboard_button.dart';
import 'package:redesprou_boilerplate_name/widgets/layout/alternative_app_screen.dart';
import 'package:redesprou_boilerplate_name/widgets/layout/custom_container.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late NotificationStore _notificationStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _notificationStore = Get.find();
    _notificationStore.countNotificationsUnread();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return AlternativeAppScreen(
          showNotifications: true,
          badgeCount: _notificationStore.notificationCount ?? 0,
          screenBody: Stack(
            children: [
              CustomContainer(),
              Column(
                children: [
                  _buildMenuButtons(context),
                  _buildQuoteArea(),
                  _buildQuoteAuthorArea(),
                  _buildAdvertasingArea(),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Container _buildMenuButtons(BuildContext context) {
    return Container(
      height: 110,
      margin: EdgeInsets.only(top: 80, left: 25, right: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DashboardButton(
            label: translate(context, 'profile'),
            image: assetIcon(name: "ic_perfil"),
            onTap: () => pushNamed(context, Routes.profileResume),
          ),
          DashboardButton(
            label: "Seguros",
            image: assetIcon(name: "ic_seguros"),
            onTap: () => pushNamed(context, Routes.insurance),
          ),
          DashboardButton(
            label: translate(context, 'Crédito'),
            image: assetIcon(name: "ic_servicos-financeiros"),
            onTap: () => pushNamed(context, Routes.credit),
          ),
        ],
      ),
    );
  }

  Container _buildQuoteArea() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 50, left: 25, right: 25),
      child: Text(
        "\"Saia da história que está prendendo você e comece uma nova história, escrita por você mesma.\"",
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 24,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Container _buildQuoteAuthorArea() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      margin: EdgeInsets.only(top: 50, left: 25, right: 25),
      child: Text(
        "Oprah Winfrey",
        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 24, fontStyle: FontStyle.italic),
        textAlign: TextAlign.left,
      ),
    );
  }

  Expanded _buildAdvertasingArea() {
    return Expanded(
        child: Container(
      color: Colors.white,
      height: 120,
      margin: EdgeInsets.only(top: 80, left: 25, right: 25, bottom: 25),
      child: Center(
        child: Text(
          "publicidade",
          style: TextStyle(color: Colors.grey),
        ),
      ),
    ));
  }
}
