import 'package:flutter/material.dart';
import 'package:redesprou_boilerplate_name/utils/locale/app_localization.dart';
import 'package:redesprou_boilerplate_name/utils/navigation_utils.dart';
import 'package:redesprou_boilerplate_name/utils/routes/routes.dart';
import 'package:redesprou_boilerplate_name/utils/translate_utils.dart';
import 'package:redesprou_boilerplate_name/widgets/buttons/add_photo_button.dart';
import 'package:redesprou_boilerplate_name/widgets/fat_button.dart';
import 'package:redesprou_boilerplate_name/widgets/form/form_section_title.dart';
import 'package:redesprou_boilerplate_name/widgets/layout/alternative_app_screen.dart';
import 'package:redesprou_boilerplate_name/widgets/layout/custom_container.dart';
import 'package:redesprou_boilerplate_name/widgets/spaced_widget.dart';

class ProfilePresentation extends StatefulWidget {
  const ProfilePresentation({Key? key}) : super(key: key);

  @override
  _ProfilePresentationState createState() => _ProfilePresentationState();
}

class _ProfilePresentationState extends State<ProfilePresentation> {
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
                _buildAddPhotoButton(),
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
        translate(context, "hello_gigworker"),
        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 24, fontWeight: FontWeight.w900),
        textAlign: TextAlign.center,
      ),
    );
  }

  Container _buildSubTitleMessage() {
    return Container(
      child: Text(
        translate(context, "profile_presentation_message"),
        style: TextStyle(
          color: Colors.grey,
          fontSize: 24,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildAddPhotoButton() {
    return Expanded(
      flex: 1,
      child: FittedBox(fit: BoxFit.fitWidth, child: Image(image: AssetImage('assets/icons/Profile_Ilustration.png'))),
    );
  }

  Widget _textButton() {
    return GestureDetector(
      onTap: () => pushNamed(context, Routes.profileStepOne),
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
      buttonText: AppLocalizations.of(context).translate('start_my_register'),
      buttonColor: Theme.of(context).primaryColor,
      textColor: Colors.white,
      onPressed: () async {
        pushAndRemoveUntil(context, Routes.profileStepOne);
      },
    );
  }
}
