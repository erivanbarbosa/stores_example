import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:redesprou_boilerplate_name/stores/profile/profile_store.dart';
import 'package:redesprou_boilerplate_name/utils/locale/app_localization.dart';
import 'package:redesprou_boilerplate_name/utils/mask_utils.dart';
import 'package:redesprou_boilerplate_name/utils/navigation_utils.dart';
import 'package:redesprou_boilerplate_name/utils/routes/routes.dart';
import 'package:redesprou_boilerplate_name/utils/translate_utils.dart';
import 'package:redesprou_boilerplate_name/widgets/buttons/add_photo_button.dart';
import 'package:redesprou_boilerplate_name/widgets/buttons/profile_photo_widget.dart';
import 'package:redesprou_boilerplate_name/widgets/default_app_screen.dart';
import 'package:redesprou_boilerplate_name/widgets/fat_button.dart';
import 'package:redesprou_boilerplate_name/widgets/form/form_section_title.dart';
import 'package:redesprou_boilerplate_name/widgets/generic_circular_progress_indicator.dart';
import 'package:redesprou_boilerplate_name/widgets/inputs/double_input_container.dart';
import 'package:redesprou_boilerplate_name/widgets/inputs/dropdown_input.dart';
import 'package:redesprou_boilerplate_name/widgets/inputs/input_inline_label.dart';
import 'package:redesprou_boilerplate_name/widgets/inputs/month_year_picker.dart';
import 'package:redesprou_boilerplate_name/widgets/screen_title_message.dart';
import 'package:redesprou_boilerplate_name/widgets/spaced_widget.dart';
import 'package:redesprou_boilerplate_name/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';

class ProfileStepTwoScreen extends StatefulWidget {
  const ProfileStepTwoScreen({Key? key}) : super(key: key);

  @override
  _ProfileStepTwoScreenState createState() => _ProfileStepTwoScreenState();
}

class _ProfileStepTwoScreenState extends State<ProfileStepTwoScreen> {
  late ProfileStore _profileStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _profileStore = Provider.of<ProfileStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return DefaultAppScreen(
        screenTitle: "create_my_profile",
        screenBody: _profileStore.loading ? [GenericCircularProgressIndicator()] : _buildBody(),
      );
    });
  }

  List<Widget> _buildBody() {
    return [
      ScreenTitleMessage(message: translate(context, "tell_us_about_your_work")),
      _buildAddPhotoButton(),
      _buildProfessionField(),
      FormSectionTitle(title: translate(context, "educational_background")),
      _buildInstituitionField(),
      SpacedWidget(_buildFormationField()),
      SpacedWidget(_buildStartDateField()),
      SpacedWidget(_buildEndDateField()),
      SpacedWidget(_buildSituationField()),
      SpacedWidget(_buildFormationDescriptionField()),
      //SpacedWidget(_findProfile()),
      SpacedWidget(_buildNextButton(), spaceBelow: true),
    ];
  }

  Widget _buildAddPhotoButton() {
    return Observer(builder: (context) {
      return _profileStore.imageLoading
          ? Container(height: 150, width: 150, child: Container(height: 50, width: 50, child: GenericCircularProgressIndicator()))
          : _profileStore.profile!.profile_photo_path == null
              ? AddPhotoButton(
                  iconName: "ic_cover",
                  label: translate(context, "add_cover_image"),
                  onTap: () async {
                    await _profileStore.addAvatar();
                    setState(() {});
                  },
                )
              : ProfilePhotoWidget(
                  size: 200,
                  coverImageUrl: _profileStore.profile!.featured_photo_path,
                  onTap: () async {
                    await _profileStore.addAvatar();
                    setState(() {});
                  },
                );
    });
  }

  Widget _buildProfessionField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('profession'),
          inputType: TextInputType.text,
          textController: _profileStore.occupationController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {},
          onFieldSubmitted: (value) {},
          errorText: null,
        );
      },
    );
  }

  Widget _buildFormationField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('formation'),
          inputType: TextInputType.text,
          textController: _profileStore.educationController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {},
          onFieldSubmitted: (value) {},
          errorText: null,
        );
      },
    );
  }

/*   Widget _buildStartDateRow() {
    return DoubleInputContainer(
      firstWidget: InputInlineLabel(label: translate(context, "month_year_start")),
      secondWidget: _buildStartDateField(context),
      firstWidgetFlex: 5,
      secondWidgetFlex: 5,
    );
  } */

  _buildStartDateField() {
    /* return Container(
      width: 100,
      child: MonthYearPicker(
        selectedDate: _profileStore.educationStart,
        onSelect: (date) {
          if (date != null) {
            setState(() {
              _profileStore.educationStart = date;
            });
          }
        },
      ),
    ); */

    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('formation'),
          inputType: TextInputType.number,
          textController: _profileStore.educationStartController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {},
          onFieldSubmitted: (value) {},
          inputFormatter: monthYearMask,
          errorText: null,
        );
      },
    );
  }

  /* Widget _buildEndDateRow() {
     return DoubleInputContainer(
      firstWidget: InputInlineLabel(label: translate(context, "month_year_end")),
      secondWidget: _buildEndDateField(context),
      firstWidgetFlex: 5,
      secondWidgetFlex: 5,
    );  

  }*/

  _buildEndDateField() {
    /* return Container(
      width: 100,
      child: MonthYearPicker(
        selectedDate: _profileStore.education,
        onSelect: (date) {
          if (date != null) {
            setState(() {
              _profileStore.educationEnd = date;
            });
          }
        },
      ),
    ); */

    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('formation'),
          inputType: TextInputType.number,
          textController: _profileStore.educationEndController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {},
          onFieldSubmitted: (value) {},
          inputFormatter: monthYearMask,
          errorText: null,
        );
      },
    );
  }

  Widget _buildInstituitionField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('instituition'),
          inputType: TextInputType.text,
          textController: _profileStore.educationLocationController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {},
          onFieldSubmitted: (value) {},
          errorText: null,
        );
      },
    );
  }

  Widget _buildSituationField() {
    return DropdownInput(
      hint: AppLocalizations.of(context).translate('situation'),
      value: _profileStore.educationStatus,
      items: [
        DropdownMenuItem(value: "DONE", child: Text(translate(context, 'DONE'))),
        DropdownMenuItem(value: "IN_PROGRESS", child: Text(translate(context, 'IN_PROGRESS'))),
      ],
      onChanged: (value) {
        setState(() {
          _profileStore.educationStatus = value!.isNotEmpty ? value : null;
        });
      },
    );
  }

  Widget _buildFormationDescriptionField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('description'),
          inputType: TextInputType.text,
          textController: _profileStore.educationDescriptionController,
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
      buttonText: AppLocalizations.of(context).translate('finish_step_two_of_two'),
      buttonColor: Theme.of(context).primaryColor,
      textColor: Colors.white,
      onPressed: () async {
        _profileStore.saveProfile().then((value) => pushAndRemoveUntil(context, Routes.dashboard));
        //pushAndRemoveUntil(context, Routes.dashboard);
      },
    );
  }
}
