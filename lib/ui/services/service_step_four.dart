import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:redesprou_boilerplate_name/stores/service/service_store.dart';
import 'package:redesprou_boilerplate_name/utils/locale/app_localization.dart';
import 'package:redesprou_boilerplate_name/utils/navigation_utils.dart';
import 'package:redesprou_boilerplate_name/utils/routes/routes.dart';
import 'package:redesprou_boilerplate_name/utils/string_utils.dart';
import 'package:redesprou_boilerplate_name/utils/translate_utils.dart';
import 'package:redesprou_boilerplate_name/widgets/default_app_screen.dart';
import 'package:redesprou_boilerplate_name/widgets/fat_button.dart';
import 'package:redesprou_boilerplate_name/widgets/inputs/CustomSwitchInput.dart';
import 'package:redesprou_boilerplate_name/widgets/inputs/custom_check_box.dart';
import 'package:redesprou_boilerplate_name/widgets/screen_title_message.dart';
import 'package:redesprou_boilerplate_name/widgets/spaced_widget.dart';
import 'package:provider/provider.dart';

class ServiceStepFourScreen extends StatefulWidget {
  const ServiceStepFourScreen({Key? key}) : super(key: key);

  @override
  _ServiceStepFourScreenState createState() => _ServiceStepFourScreenState();
}

class _ServiceStepFourScreenState extends State<ServiceStepFourScreen> {
  late ServiceStore _serviceStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _serviceStore = Get.find();
    _serviceStore.loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultAppScreen(
      screenTitle: "create_my_services",
      screenBody: _buildBody(),
    );
  }

  List<Widget> _buildBody() {
    return [
      ScreenTitleMessage(message: translate(context, "availability")),
      SizedBox(height: 30),
      _buildDaysContainer(),
      _buildEntireDayButton(),
      _buildPeriodContainer(),
      SizedBox(
        height: 250,
      ),
      SpacedWidget(_buildNextButton(), spaceBelow: true),
    ];
  }

  _buildDaysContainer() {
    return Wrap(
      children: [
        _buildCheckBox(
            label: "monday",
            value: _isDayChecked("monday"),
            onChanged: (bool? value) {
              value! ? _serviceStore.daysOfWeek.add("monday") : _serviceStore.daysOfWeek.remove("monday");
              setState(() {});
            },
            width: 125),
        _buildCheckBox(
            label: "tuesday",
            value: _isDayChecked("tuesday"),
            onChanged: (bool? value) {
              value! ? _serviceStore.daysOfWeek.add("tuesday") : _serviceStore.daysOfWeek.remove("tuesday");
              setState(() {});
            },
            width: 115),
        _buildCheckBox(
            label: "wednesday",
            value: _isDayChecked("wednesday"),
            onChanged: (bool? value) {
              value! ? _serviceStore.daysOfWeek.add("wednesday") : _serviceStore.daysOfWeek.remove("wednesday");
              setState(() {});
            },
            width: 120),
        _buildCheckBox(
            label: "thursday",
            value: _isDayChecked("thursday"),
            onChanged: (bool? value) {
              value! ? _serviceStore.daysOfWeek.add("thursday") : _serviceStore.daysOfWeek.remove("thursday");
              setState(() {});
            },
            width: 120),
        _buildCheckBox(
            label: "friday",
            value: _isDayChecked("friday"),
            onChanged: (bool? value) {
              value! ? _serviceStore.daysOfWeek.add("friday") : _serviceStore.daysOfWeek.remove("friday");
              setState(() {});
            },
            width: 120),
        _buildCheckBox(
            label: "saturday",
            value: _isDayChecked("saturday"),
            onChanged: (bool? value) {
              value! ? _serviceStore.daysOfWeek.add("saturday") : _serviceStore.daysOfWeek.remove("saturday");
              setState(() {});
            },
            width: 120),
        _buildCheckBox(
            label: "sunday",
            value: _isDayChecked("sunday"),
            onChanged: (bool? value) {
              value! ? _serviceStore.daysOfWeek.add("sunday") : _serviceStore.daysOfWeek.remove("sunday");
              setState(() {});
            },
            width: 130),
      ],
    );
  }

  bool _isDayChecked(String day) {
    return _serviceStore.daysOfWeek.contains(day);
  }

  _buildCheckBox({required String label, required bool value, dynamic onChanged, double width = 130}) {
    return Container(
      width: width,
      child: CustomCheckBoxInput(
        label: translate(context, label),
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  _buildEntireDayButton() {
    return CustomSwitchInput(
      label: translate(context, "entire_day"),
      value: _serviceStore.entireDay,
      onChanged: (value) {
        setState(() {
          _serviceStore.attendanceOnMorning = false;
          _serviceStore.attendanceOnAfternoon = false;
          _serviceStore.entireDay = value ?? false;
        });
      },
    );
  }

  _buildPeriodContainer() {
    return Observer(
      builder: (context) {
        return Visibility(
          visible: _serviceStore.entireDay == false,
          child: Wrap(
            children: [
              _buildCheckBox(label: "morning", value: _serviceStore.attendanceOnMorning, onChanged: atMorningChanged, width: 140),
              _buildCheckBox(label: "evening", value: _serviceStore.attendanceOnAfternoon, onChanged: atAfternoonChanged, width: 140),
              _buildCheckBox(label: "night_period", value: _serviceStore.attendanceOnNight, onChanged: atNightChanged, width: 140),
            ],
          ),
        );
      },
    );
  }

  atMorningChanged(bool? value) {
    setState(() {
      _serviceStore.attendanceOnMorning = value ?? false;
    });
  }

  atAfternoonChanged(bool? value) {
    setState(() {
      _serviceStore.attendanceOnAfternoon = value ?? false;
    });
  }

  atNightChanged(bool? value) {
    setState(() {
      _serviceStore.attendanceOnNight = value ?? false;
    });
  }

  Widget _buildNextButton() {
    return MainButton(
      buttonText: AppLocalizations.of(context).translate('next_step_four_of_five'),
      buttonColor: Colors.white,
      textColor: Theme.of(context).primaryColor,
      borderColor: Theme.of(context).primaryColor,
      onPressed: () async {
        pushNamed(context, Routes.serviceStepFive);
      },
    );
  }
}
