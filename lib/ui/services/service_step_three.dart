import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:redesprou_boilerplate_name/stores/service/service_store.dart';
import 'package:redesprou_boilerplate_name/utils/locale/app_localization.dart';
import 'package:redesprou_boilerplate_name/utils/mask_utils.dart';
import 'package:redesprou_boilerplate_name/utils/navigation_utils.dart';
import 'package:redesprou_boilerplate_name/utils/routes/routes.dart';
import 'package:redesprou_boilerplate_name/utils/string_utils.dart';
import 'package:redesprou_boilerplate_name/utils/translate_utils.dart';
import 'package:redesprou_boilerplate_name/widgets/default_app_screen.dart';
import 'package:redesprou_boilerplate_name/widgets/fat_button.dart';
import 'package:redesprou_boilerplate_name/widgets/form/form_section_title.dart';
import 'package:redesprou_boilerplate_name/widgets/inputs/city_input.dart';
import 'package:redesprou_boilerplate_name/widgets/inputs/custom_check_box.dart';
import 'package:redesprou_boilerplate_name/widgets/inputs/state_input.dart';
import 'package:redesprou_boilerplate_name/widgets/screen_title_message.dart';
import 'package:redesprou_boilerplate_name/widgets/spaced_widget.dart';
import 'package:redesprou_boilerplate_name/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';

class ServiceStepThreeScreen extends StatefulWidget {
  const ServiceStepThreeScreen({Key? key}) : super(key: key);

  @override
  _ServiceStepThreeScreenState createState() => _ServiceStepThreeScreenState();
}

class _ServiceStepThreeScreenState extends State<ServiceStepThreeScreen> {
  late ServiceStore _serviceStore;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _serviceStore = Get.find();
    _serviceStore.loading = false;
    await _serviceStore.findStates();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultAppScreen(
      screenTitle: "Cadastrar serviço",
      screenBody: _buildBody(),
    );
  }

  List<Widget> _buildBody() {
    return [
      ScreenTitleMessage(message: translate(context, "place_of_service")),
      Observer(builder: (context) {
        return CustomCheckBoxInput(
          label: translate(context, "at_house"),
          value: _serviceStore.home_care,
          onChanged: onHomeCareChanged,
        );
      }),
      Observer(builder: (context) {
        return CustomCheckBoxInput(
          label: translate(context, "at_home"),
          value: _serviceStore.own_address,
          onChanged: onOwnAddressChanged,
        );
      }),
      _buildAddress(),
      SpacedWidget(_buildNextButton(), spaceBelow: true),
    ];
  }

  _buildAddress() {
    return Observer(
      builder: (context) {
        return isTrue(_serviceStore.own_address)
            ? Column(
                children: [
                  FormSectionTitle(title: translate(context, "address")),
                  _buildStateField(),
                  SpacedWidget(_buildCityField()),
                  SpacedWidget(_buildZipField()),
                  SpacedWidget(_buildAddressOneField()),
                  SpacedWidget(_buildAddressTwoField()),
                  SizedBox(height: 30),
                ],
              )
            : Container(height: 399);
      },
    );
  }

  onHomeCareChanged(bool? value) {
    _serviceStore.home_care = value ?? false;
  }

  onOwnAddressChanged(bool? value) {
    if (isFalse(value)) _serviceStore.resetAddress();
    _serviceStore.own_address = value ?? false;
  }

  Widget _buildStateField() {
    return Observer(builder: (context) {
      if (_serviceStore.states == null) _serviceStore.states = [];
      List<DropdownMenuItem<int>> stateList = _serviceStore.states!.map((state) => DropdownMenuItem(value: state.id, child: Text(state.name!))).toList();

      return StateInput(
          states: stateList,
          value: _serviceStore.state,
          onChanged: (value) async {
            _serviceStore.state = value;
            _serviceStore.city = null;
            await _serviceStore.findCities();
          });
    });
  }

  Widget _buildCityField() {
    return Observer(builder: (context) {
      if (_serviceStore.cities == null) _serviceStore.cities = [];
      List<DropdownMenuItem<int>> cityList = _serviceStore.cities!.map((city) => DropdownMenuItem(value: city.id, child: Text(city.name!))).toList();
      return CityInput(
          value: _serviceStore.city,
          cities: cityList,
          onChanged: (value) {
            _serviceStore.city = value;
          });
    });
  }

  Widget _buildZipField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('zip_code'),
          inputType: TextInputType.number,
          textController: _serviceStore.serviceZipCodeController,
          inputAction: TextInputAction.next,
          inputFormatter: zipMask,
          autoFocus: false,
          onChanged: (value) {},
          onFieldSubmitted: (value) {},
          errorText: null,
        );
      },
    );
  }

  Widget _buildAddressOneField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('public_area'),
          inputType: TextInputType.text,
          textController: _serviceStore.serviceAddressOneController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {},
          onFieldSubmitted: (value) {},
          errorText: null,
        );
      },
    );
  }

  Widget _buildAddressTwoField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('address_2'),
          inputType: TextInputType.text,
          textController: _serviceStore.serviceAddressTwoController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {},
          onFieldSubmitted: (value) {},
          errorText: null,
        );
      },
    );
  }

  Widget _buildNextButton() {
    return MainButton(
      buttonText: AppLocalizations.of(context).translate('next_step_three_of_five'),
      buttonColor: Colors.white,
      textColor: Theme.of(context).primaryColor,
      borderColor: Theme.of(context).primaryColor,
      onPressed: () async {
        pushNamed(context, Routes.serviceStepFour);
      },
    );
  }
}
