import 'package:flutter/material.dart';
import 'package:redesprou_boilerplate_name/utils/locale/app_localization.dart';
import 'package:redesprou_boilerplate_name/utils/navigation_utils.dart';
import 'package:redesprou_boilerplate_name/utils/routes/routes.dart';
import 'package:redesprou_boilerplate_name/utils/translate_utils.dart';
import 'package:redesprou_boilerplate_name/widgets/fat_button.dart';
import 'package:redesprou_boilerplate_name/widgets/form/form_section_title.dart';
import 'package:redesprou_boilerplate_name/widgets/layout/alternative_app_screen.dart';
import 'package:redesprou_boilerplate_name/widgets/layout/custom_container.dart';
import 'package:redesprou_boilerplate_name/widgets/spaced_widget.dart';

class ServicePresentation extends StatefulWidget {
  const ServicePresentation({Key? key}) : super(key: key);

  @override
  _ServicePresentationState createState() => _ServicePresentationState();
}

class _ServicePresentationState extends State<ServicePresentation> {
  @override
  Widget build(BuildContext context) {
    return AlternativeAppScreen(
      screenBody: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(25),
        child: Stack(
          children: [
            CustomContainer(),
            Column(
              children: [
                _buildTitleMessage(),
                SizedBox(height: 30),
                _buildSubTitleMessage(),
                SizedBox(height: 30),
                _buildBanner(),
                SizedBox(height: 30),
                SpacedWidget(_buildNextButton()),
                _textButton(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Container _buildTitleMessage() {
    return Container(
      child: Text(
        translate(context, "profile_sucess_saving"),
        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 24, fontWeight: FontWeight.w900),
        textAlign: TextAlign.center,
      ),
    );
  }

  Container _buildSubTitleMessage() {
    return Container(
      child: Text(
        translate(context, "services_presentation_message"),
        style: TextStyle(
          color: Colors.grey,
          fontSize: 24,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildBanner() {
    return Expanded(
      flex: 1,
      child: FittedBox(fit: BoxFit.fitWidth, child: Image(image: AssetImage('assets/icons/Services_Ilustration.png'))),
    );
  }

  Widget _textButton() {
    return GestureDetector(
      onTap: () => pushNamed(context, Routes.serviceStepOne),
      child: FormSectionTitle(
          title: translate(
            context,
            "continue_from_stopped_point",
          ),
          top: 10),
    );
  }

  Widget _buildNextButton() {
    return MainButton(
      buttonText: AppLocalizations.of(context).translate('start_my_services'),
      buttonColor: Theme.of(context).primaryColor,
      textColor: Colors.white,
      onPressed: () async {
        pushAndRemoveUntil(context, Routes.serviceStepOne);
      },
    );
  }
}
