import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:redesprou_boilerplate_name/utils/routes/routes.dart';
import 'package:redesprou_boilerplate_name/widgets/layout/alternative_app_screen.dart';
import 'package:redesprou_boilerplate_name/widgets/layout/custom_container.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return AlternativeAppScreen(
          showNotifications: true,
          floatingActionButton: FloatingActionButton(
          onPressed: () => {Navigator.of(context).pushNamed(Routes.new_contact)},
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
          screenBody: Stack(
            children: [
              CustomContainer(),
              Column(
                children: [
                  _buildQuoteArea(),
                  _buildAdvertasingArea(),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Container _buildQuoteArea() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 50, left: 25, right: 25),
      child: Text(
        "\"Taps: 0\"",
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 24,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Expanded _buildAdvertasingArea() {
    return Expanded(
        child: Container(
      color: Colors.white,
      height: 120,
      margin: EdgeInsets.only(top: 80, left: 25, right: 25, bottom: 25),
      child: Center(),
    ));
  }
}
