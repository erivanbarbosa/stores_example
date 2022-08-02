import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:redesprou_boilerplate_name/stores/courses/course_store.dart';
import 'package:redesprou_boilerplate_name/utils/locale/app_localization.dart';
import 'package:redesprou_boilerplate_name/utils/mask_utils.dart';
import 'package:redesprou_boilerplate_name/utils/navigation_utils.dart';
import 'package:redesprou_boilerplate_name/utils/routes/routes.dart';
import 'package:redesprou_boilerplate_name/utils/translate_utils.dart';
import 'package:redesprou_boilerplate_name/widgets/default_app_screen.dart';
import 'package:redesprou_boilerplate_name/widgets/fat_button.dart';
import 'package:redesprou_boilerplate_name/widgets/generic_circular_progress_indicator.dart';
import 'package:redesprou_boilerplate_name/widgets/inputs/double_input_container.dart';
import 'package:redesprou_boilerplate_name/widgets/inputs/dropdown_input.dart';
import 'package:redesprou_boilerplate_name/widgets/inputs/input_inline_label.dart';
import 'package:redesprou_boilerplate_name/widgets/inputs/month_year_picker.dart';
import 'package:redesprou_boilerplate_name/widgets/screen_title_message.dart';
import 'package:redesprou_boilerplate_name/widgets/spaced_widget.dart';
import 'package:redesprou_boilerplate_name/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({Key? key}) : super(key: key);

  @override
  _CoursesScreenState createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  late CourseStore _courseStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _courseStore = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return DefaultAppScreen(
          screenTitle: "free_courses",
          screenBody: _courseStore.loading ? [GenericCircularProgressIndicator()] : _buildBody(),
        );
      },
    );
  }

  List<Widget> _buildBody() {
    return [
      ScreenTitleMessage(message: translate(context, "course_information_message")),
      SizedBox(height: 40),
      _buildFreeCourseInstituitionField(),
      SpacedWidget(_buildFreeCourseFormationField()),
      SpacedWidget(_buildFreeCourseStartDateField()),
      SpacedWidget(_buildFreeCourseEndDateField()),
      SpacedWidget(_buildFreeCourseSituationField()),
      SpacedWidget(_buildFreeCourseDescriptionField()),
      SizedBox(height: 40),
      SpacedWidget(_buildNextButton(), spaceBelow: true),
    ];
  }

  Widget _buildFreeCourseInstituitionField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('instituition'),
          inputType: TextInputType.text,
          textController: _courseStore.courseLocationController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {},
          onFieldSubmitted: (value) {},
          errorText: null,
        );
      },
    );
  }

  Widget _buildFreeCourseFormationField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('formation'),
          inputType: TextInputType.text,
          textController: _courseStore.courseTitleController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {},
          onFieldSubmitted: (value) {},
          errorText: null,
        );
      },
    );
  }

/*   Widget _buildFreeCourseStartField() {
    return DoubleInputContainer(
      firstWidget: InputInlineLabel(label: translate(context, "month_year_start")),
      secondWidget: _buildFreeCourseStartDateField(context),
      firstWidgetFlex: 5,
      secondWidgetFlex: 5,
    );
  } */

  _buildFreeCourseStartDateField() {
    /* return Container(
      width: 100,
      child: MonthYearPicker(
        selectedDate: _courseStore.courseStart,
        onSelect: (date) {
          if (date != null) {
            setState(() {
              _courseStore.courseStart = date;
            });
          }
        },
      ),
    ); */

    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('MM/AAAA'),
          inputType: TextInputType.number,
          textController: _courseStore.courseStartController,
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

/*   Widget _buildFreeCourseEndField() {
    return DoubleInputContainer(
      firstWidget: InputInlineLabel(label: translate(context, "month_year_end")),
      secondWidget: _buildFreeCourseEndDateField(context),
      firstWidgetFlex: 5,
      secondWidgetFlex: 5,
    );
  } */

  _buildFreeCourseEndDateField() {
    /* return Container(
      width: 100,
      child: MonthYearPicker(
        selectedDate: this._courseStore.courseEnd,
        onSelect: (date) {
          if (date != null) {
            setState(() {
              _courseStore.courseEnd = date;
            });
          }
        },
      ),
    ); */

    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('MM/AAAA'),
          inputType: TextInputType.number,
          textController: _courseStore.courseEndController,
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

  Widget _buildFreeCourseSituationField() {
    return DropdownInput(
      hint: AppLocalizations.of(context).translate('situation'),
      value: _courseStore.courseStatus,
      items: [
        DropdownMenuItem(value: "DONE", child: Text(translate(context, 'DONE'))),
        DropdownMenuItem(value: "IN_PROGRESS", child: Text(translate(context, 'IN_PROGRESS'))),
      ],
      onChanged: (value) {
        setState(() {
          _courseStore.courseStatus = value!.isNotEmpty ? value : null;
        });
      },
    );
  }

  Widget _buildFreeCourseDescriptionField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('description'),
          inputType: TextInputType.text,
          textController: _courseStore.courseDescriptionController,
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
      buttonText: AppLocalizations.of(context).translate('add_course'),
      buttonColor: Theme.of(context).primaryColor,
      textColor: Colors.white,
      onPressed: () async {
        _courseStore.courseId != null ? await _courseStore.updateCourse() : await _courseStore.saveCourse();
        Navigator.pop(context, 'success');
      },
    );
  }
}
