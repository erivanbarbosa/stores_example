import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:redesprou_boilerplate_name/constants/colors.dart';
import 'package:redesprou_boilerplate_name/models/courses/course.dart';
import 'package:redesprou_boilerplate_name/models/services/service.dart';
import 'package:redesprou_boilerplate_name/stores/courses/course_store.dart';
import 'package:redesprou_boilerplate_name/stores/profile/profile_store.dart';
import 'package:redesprou_boilerplate_name/stores/service/service_store.dart';
import 'package:redesprou_boilerplate_name/ui/courses/course_widget.dart';
import 'package:redesprou_boilerplate_name/ui/services/service_resume.dart';
import 'package:redesprou_boilerplate_name/ui/services/service_widget.dart';
import 'package:redesprou_boilerplate_name/utils/date_utils.dart';
import 'package:redesprou_boilerplate_name/utils/navigation_utils.dart';
import 'package:redesprou_boilerplate_name/utils/routes/routes.dart';
import 'package:redesprou_boilerplate_name/utils/string_utils.dart';
import 'package:redesprou_boilerplate_name/utils/translate_utils.dart';
import 'package:redesprou_boilerplate_name/widgets/buttons/profile_photo_widget.dart';
import 'package:redesprou_boilerplate_name/widgets/default_app_screen.dart';
import 'package:redesprou_boilerplate_name/widgets/form/form_section_title.dart';
import 'package:redesprou_boilerplate_name/widgets/form_section_title_button.dart';
import 'package:redesprou_boilerplate_name/widgets/spaced_widget.dart';
import 'package:redesprou_boilerplate_name/widgets/texts/center_text.dart';
import 'package:redesprou_boilerplate_name/widgets/texts/title_message.dart';
import 'package:provider/provider.dart';

class ProfileResumeScreen extends StatefulWidget {
  const ProfileResumeScreen({Key? key}) : super(key: key);

  @override
  _ProfileResumeScreenState createState() => _ProfileResumeScreenState();
}

class _ProfileResumeScreenState extends State<ProfileResumeScreen> {
  late ProfileStore _profileStore;
  late ServiceStore _serviceStore;
  late CourseStore _courseStore;
  double formSectionTitleSize = 20;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _serviceStore = Get.find();
    _courseStore = Get.find();
    _profileStore = Provider.of<ProfileStore>(context);
    _profileStore.getProfile();
    _profileStore.findStates();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return DefaultAppScreen(
        screenTitle: "profile",
        screenBody: _profileStore.loading ? [] : _buildBody(),
        loading: _profileStore.loading,
        contentAlign: Alignment.topCenter,
      );
    });
  }

  List<Widget> _buildBody() {
    return [
      _buildProfilePhotoButton(),
      _buildTitleRow(),
      FormSectionTitle(title: _profileStore.profile!.occupation!, alignment: TextAlign.center, top: 0, fontSize: formSectionTitleSize),
      FormSectionTitle(title: translate(context, "educational_background"), alignment: TextAlign.center, top: 0, fontSize: formSectionTitleSize),
      CenterText(text: _profileStore.profile!.education!),
      CenterText(text: _profileStore.profile!.education_location!),
      CenterText(text: _getDates()),
      CenterText(text: _profileStore.profile!.education_description!),
      Divider(),
      SpacedWidget(FormSectionTitleButton(
          title: translate(context, "free_courses"),
          fontSize: formSectionTitleSize,
          icon: Icons.add_circle_outline,
          bottom: 0,
          onTap: () async {
            _courseStore.reset();
            final result = await Navigator.of(context).pushNamed(Routes.freeCourses);
            if (result == "success") {
              await _profileStore.getProfile();
              setState(() {});
            }
          })),
      _buildCourses(),
      SpacedWidget(FormSectionTitleButton(
          title: translate(context, "services"),
          fontSize: formSectionTitleSize,
          icon: Icons.add_circle_outline,
          bottom: 0,
          onTap: () async {
            _serviceStore.reset();
            final result = await Navigator.of(context).pushNamed(Routes.serviceStepOne);
            if (result == "success") {
              _profileStore.getProfile();
            }
          })),
      _buildServices()
    ];
  }

  String _getDates() {
    String? start = _profileStore.profile!.education_start;
    String? end = _profileStore.profile!.education_end;
    bool hasStart = isNotBlank(_profileStore.profile!.education_start!);
    bool hasEnd = isNotBlank(_profileStore.profile!.education_end!);

    if (hasStart && hasEnd) {
      return "${getDateYear(start!)} - ${getDateYear(end!)}";
    } else if (hasStart && !hasEnd) {
      return "${getDateYear(start!)}";
    } else if (!hasStart && hasEnd) {
      return "${getDateYear(end!)}";
    } else {
      return "";
    }
  }

  getDateYear(String date) {
    return getYear(date);
  }

  Widget _buildProfilePhotoButton() {
    return isNotBlank(_profileStore.profile!.profile_photo_path!) || isNotBlank(_profileStore.profile!.featured_photo_path!)
        ? ProfilePhotoWidget(
            profileImageUrl: _profileStore.profile!.profile_photo_path!,
            coverImageUrl: _profileStore.profile!.featured_photo_path!,
            onTap: () {
              pushNamed(context, Routes.profileStepOne);
            },
          )
        : ProfilePhotoWidget(
            profileImageUrl: 'assets/icons/img_profile.png',
            assetImage: true,
            onTap: () {
              pushNamed(context, Routes.profileStepOne);
            },
          );
  }

  Widget _buildTitleRow() {
    return Stack(
      alignment: Alignment.center,
      children: [
        TitleMessage(title: _profileStore.profile!.name!),
        Container(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () {
              pushNamed(context, Routes.profileStepOne);
            },
            icon: Icon(Icons.edit),
          ),
        ),
      ],
    );
  }

  _buildCourses() {
    List<Course> courses = _profileStore.profile!.courses!;
    if (courses.length > 0) {
      List<Widget> courseWidgets = courses.map((e) => _buildCourseWidget(e)).toList();
      return Column(
        children: courseWidgets,
      );
    } else {
      return Container();
    }
  }

  Widget _buildCourseWidget(Course course) {
    return GestureDetector(
      onTap: () {
        _courseStore.loadForm(course);
        pushNamed(context, Routes.freeCourses);
      },
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        direction: Axis.horizontal,
        child: CourseWidget(course: course),
        secondaryActions: _courseSecondaryActions(course),
      ),
    );
  }

  List<Widget> _courseSecondaryActions(Course course) {
    return <Widget>[
      IconSlideAction(
        caption: 'Excluir',
        color: AppColors.purple[500]!,
        icon: Icons.delete,
        onTap: () async {
          await _courseStore.deleteCourse(course.id!);
          _profileStore.profile!.courses!.remove(course);
          setState(() {});
        },
      ),
    ];
  }

  Widget _buildServices() {
    List<Service> services = _profileStore.profile!.services!;
    if (services.length > 0) {
      List<Widget> serviceWidgets = services.map((e) => _buildServiceWidget(e)).toList();
      return Column(children: serviceWidgets);
    } else {
      return Container();
    }
  }

  GestureDetector _buildServiceWidget(Service e) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              settings: RouteSettings(name: Routes.serviceResume),
              builder: (context) => ServiceResumeScree(service: e),
            ));
      },
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        direction: Axis.horizontal,
        child: ServiceWidget(service: e),
        secondaryActions: _secondaryActions(e),
      ),
    );
  }

  List<Widget> _secondaryActions(Service service) {
    return <Widget>[
      IconSlideAction(
        caption: 'Excluir',
        color: AppColors.purple[500]!,
        icon: Icons.delete,
        onTap: () async {
          await _serviceStore.deleteService(service.id!);
          _profileStore.profile!.services!.remove(service);
          setState(() {});
        },
      ),
    ];
  }
}
