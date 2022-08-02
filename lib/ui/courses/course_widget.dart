import 'package:flutter/material.dart';

import 'package:redesprou_boilerplate_name/models/courses/course.dart';
import 'package:redesprou_boilerplate_name/utils/translate_utils.dart';
import 'package:redesprou_boilerplate_name/widgets/texts/center_text.dart';

class CourseWidget extends StatelessWidget {
  final Course course;
  const CourseWidget({
    Key? key,
    required this.course,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: _buildCourse(course, context),
    );
  }

  _buildCourse(Course course, context) {
    return Column(
      children: [
        CenterText(
          text: course.title!,
          fontSize: 16,
        ),
        CenterText(text: course.location!),
        CenterText(text: course.description!),
        CenterText(text: _getCourseDate(course.start, course.end)),
        CenterText(text: translate(context, course.status!)),
        Divider(),
      ],
    );
  }

  String _getCourseDate(String? start, String? end) {
    String result = "";
    if (start != null && start.isNotEmpty) {
      if (end != null && end.isNotEmpty) {
        result = "$start - $end";
      } else {
        result = start;
      }
    }
    return result;
  }
}
