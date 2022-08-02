import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:redesprou_boilerplate_name/stores/service/service_store.dart';
import 'package:redesprou_boilerplate_name/utils/locale/app_localization.dart';
import 'package:redesprou_boilerplate_name/utils/navigation_utils.dart';
import 'package:redesprou_boilerplate_name/utils/routes/routes.dart';
import 'package:redesprou_boilerplate_name/utils/translate_utils.dart';
import 'package:redesprou_boilerplate_name/widgets/buttons/add_photo_button.dart';
import 'package:redesprou_boilerplate_name/widgets/default_app_screen.dart';
import 'package:redesprou_boilerplate_name/widgets/fat_button.dart';
import 'package:redesprou_boilerplate_name/widgets/generic_circular_progress_indicator.dart';
import 'package:redesprou_boilerplate_name/widgets/image_gallery.dart';
import 'package:redesprou_boilerplate_name/widgets/screen_title_message.dart';
import 'package:redesprou_boilerplate_name/widgets/spaced_widget.dart';
import 'package:provider/provider.dart';

class ServiceStepTwoScreen extends StatefulWidget {
  const ServiceStepTwoScreen({Key? key}) : super(key: key);

  @override
  _ServiceStepTwoScreenState createState() => _ServiceStepTwoScreenState();
}

class _ServiceStepTwoScreenState extends State<ServiceStepTwoScreen> {
  late ServiceStore _serviceStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _serviceStore = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultAppScreen(
      screenTitle: "create_my_services",
      screenBody: _buildBody(),
    );
  }

  List<Widget> _buildBody() {
    _serviceStore.imageLoading = false;
    return [
      ScreenTitleMessage(message: translate(context, "services_photo_message")),
      _buildAddPhotoButton(),
      _buildGallery(),
      SpacedWidget(_buildNextButton(), spaceBelow: true),
    ];
  }

  Widget _buildAddPhotoButton() {
    return Observer(
      builder: (context) {
        return _serviceStore.imageLoading
            ? Container(height: 150, width: 150, child: Container(height: 50, width: 50, child: GenericCircularProgressIndicator()))
            : AddPhotoButton(
                iconName: "ic_cover",
                label: translate(context, "add_images"),
                onTap: () async {
                  await _serviceStore.addImage();
                  setState(() {});
                },
              );
      },
    );
  }

  _buildGallery() {
    return Observer(builder: (context) {
      return Container(
        height: 350,
        child: ImageGallery(
          medias: _serviceStore.medias,
        ),
      );
    });
  }

  Widget _buildNextButton() {
    return MainButton(
      buttonText: AppLocalizations.of(context).translate('next_step_two_of_five'),
      buttonColor: Colors.white,
      textColor: Theme.of(context).primaryColor,
      borderColor: Theme.of(context).primaryColor,
      onPressed: () async {
        pushNamed(context, Routes.serviceStepThree);
      },
    );
  }
}
