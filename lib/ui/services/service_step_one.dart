import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:redesprou_boilerplate_name/models/id_and_name.dart';
import 'package:redesprou_boilerplate_name/stores/service/service_store.dart';
import 'package:redesprou_boilerplate_name/utils/locale/app_localization.dart';
import 'package:redesprou_boilerplate_name/utils/navigation_utils.dart';
import 'package:redesprou_boilerplate_name/utils/routes/routes.dart';
import 'package:redesprou_boilerplate_name/utils/translate_utils.dart';
import 'package:redesprou_boilerplate_name/widgets/default_app_screen.dart';
import 'package:redesprou_boilerplate_name/widgets/fat_button.dart';
import 'package:redesprou_boilerplate_name/widgets/generic_circular_progress_indicator.dart';
import 'package:redesprou_boilerplate_name/widgets/inputs/category_check_box.dart';
import 'package:redesprou_boilerplate_name/widgets/screen_title_message.dart';
import 'package:redesprou_boilerplate_name/widgets/spaced_widget.dart';
import 'package:redesprou_boilerplate_name/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';

class ServiceStepOneScreen extends StatefulWidget {
  const ServiceStepOneScreen({Key? key}) : super(key: key);

  @override
  _ServiceStepOneScreenState createState() => _ServiceStepOneScreenState();
}

class _ServiceStepOneScreenState extends State<ServiceStepOneScreen> {
  late ServiceStore _serviceStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _serviceStore = Get.find();
    _serviceStore.getCategories();
    _serviceStore.loading = false;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return DefaultAppScreen(
          screenTitle: "create_my_services",
          screenBody: _serviceStore.loading ? [GenericCircularProgressIndicator()] : _buildBody(),
          loading: _serviceStore.loading,
        );
      },
    );
  }

  List<Widget> _buildBody() {
    return [
      _buildServiceNameField(),
      SpacedWidget(_buildServiceDescriptionField()),
      SizedBox(height: 30),
      SpacedWidget(ScreenTitleMessage(message: translate(context, "select_service_categories"))),
      _buildCheckBoxes(),
      SpacedWidget(_buildNextButton(), spaceBelow: true),
    ];
  }

  Widget _buildServiceNameField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('Título'),
          inputType: TextInputType.text,
          textController: _serviceStore.serviceTitleController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {},
          onFieldSubmitted: (value) {},
          errorText: null,
        );
      },
    );
  }

  Widget _buildServiceDescriptionField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('description'),
          inputType: TextInputType.text,
          textController: _serviceStore.serviceDescriptionController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {},
          onFieldSubmitted: (value) {},
          errorText: null,
        );
      },
    );
  }

  _buildCheckBoxes() {
    return Observer(builder: (context) {
      List<Widget> inputs = _serviceStore.categories!
          .map(
            (service) => Observer(builder: (context) {
              return CategoryCheckBoxInput(
                label: service.name!,
                value: _isChecked(service),
                onChanged: (bool? value) {
                  if (value!) {
                    _serviceStore.selectedCategories!.add(service.id!);
                    setState(() {});
                  } else {
                    _serviceStore.selectedCategories!.remove(service.id!);
                    setState(() {});
                  }
                },
              );
            }),
          )
          .toList();

      return Column(
        children: inputs,
      );
    });
  }

  _isChecked(IdAndName service) {
    return _serviceStore.selectedCategories!.contains(service.id);
  }

  Widget _buildNextButton() {
    return MainButton(
      buttonText: AppLocalizations.of(context).translate('next_step_one_of_five'),
      buttonColor: Colors.white,
      textColor: Theme.of(context).primaryColor,
      borderColor: Theme.of(context).primaryColor,
      onPressed: () async {
        if (_serviceStore.serviceId == null) {
          _serviceStore.saveService().then((value) {
            pushNamed(context, Routes.serviceStepTwo);
          });
        } else {
          pushNamed(context, Routes.serviceStepTwo);
        }
      },
    );
  }
}
