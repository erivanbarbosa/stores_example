import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:redesprou_boilerplate_name/stores/service/service_store.dart';
import 'package:redesprou_boilerplate_name/utils/locale/app_localization.dart';
import 'package:redesprou_boilerplate_name/utils/navigation_utils.dart';
import 'package:redesprou_boilerplate_name/utils/routes/routes.dart';
import 'package:redesprou_boilerplate_name/utils/translate_utils.dart';
import 'package:redesprou_boilerplate_name/widgets/default_app_screen.dart';
import 'package:redesprou_boilerplate_name/widgets/fat_button.dart';
import 'package:redesprou_boilerplate_name/widgets/form/form_section_title.dart';
import 'package:redesprou_boilerplate_name/widgets/generic_circular_progress_indicator.dart';
import 'package:redesprou_boilerplate_name/widgets/screen_title_message.dart';
import 'package:redesprou_boilerplate_name/widgets/spaced_widget.dart';
import 'package:redesprou_boilerplate_name/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';

class ServiceStepFiveScreen extends StatefulWidget {
  const ServiceStepFiveScreen({Key? key}) : super(key: key);

  @override
  _ServiceStepFiveScreenState createState() => _ServiceStepFiveScreenState();
}

class _ServiceStepFiveScreenState extends State<ServiceStepFiveScreen> {
  late ServiceStore _serviceStore;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _serviceStore = Get.find();
    _serviceStore.loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return DefaultAppScreen(
          screenTitle: "create_my_services",
          screenBody: _serviceStore.loading ? [GenericCircularProgressIndicator()] : _buildBody(),
        );
      },
    );
  }

  List<Widget> _buildBody() {
    return [
      ScreenTitleMessage(message: translate(context, "service_warranty")),
      SpacedWidget(_buildWarrantyDescriptionField()),
      SizedBox(height: 30),
      ScreenTitleMessage(message: translate(context, "resources_used")),
      FormSectionTitle(title: translate(context, "on_me")),
      _buildResourcesDescriptionField(),
      FormSectionTitle(title: translate(context, "on_client")),
      _buildResourcesOnClientField(),
      SizedBox(height: 150),
      SpacedWidget(_buildNextButton(), spaceBelow: true),
    ];
  }

  Widget _buildWarrantyDescriptionField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('description'),
          inputType: TextInputType.text,
          textController: _serviceStore.serviceGuaranteeController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {},
          onFieldSubmitted: (value) {},
          errorText: null,
        );
      },
    );
  }

  Widget _buildResourcesDescriptionField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('description'),
          inputType: TextInputType.text,
          textController: _serviceStore.serviceMyResponsibilityController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {},
          onFieldSubmitted: (value) {},
          errorText: null,
        );
      },
    );
  }

  Widget _buildResourcesOnClientField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('description'),
          inputType: TextInputType.text,
          textController: _serviceStore.serviceCustomerResponsabilityController,
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
      buttonText: AppLocalizations.of(context).translate('finish_step_five_of_five'),
      buttonColor: Theme.of(context).primaryColor,
      textColor: Colors.white,
      onPressed: () async {
        await _serviceStore.updateService().then((value) => pushAndRemoveUntil(context, Routes.dashboard));
      },
    );
  }
}
