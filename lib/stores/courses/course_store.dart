import 'package:flutter/material.dart';
import 'package:redesprou_boilerplate_name/data/network/apis/courses/course_api.dart';
import 'package:redesprou_boilerplate_name/models/courses/course.dart';
import 'package:mobx/mobx.dart';

part 'course_store.g.dart';

class CourseStore extends _CourseStore with _$CourseStore {}

abstract class _CourseStore with Store {
  TextEditingController courseLocationController = TextEditingController();
  TextEditingController courseTitleController = TextEditingController();
  // DateTime? courseStart;
  // DateTime? courseEnd;
  String? courseStatus;
  TextEditingController courseDescriptionController = TextEditingController();
  TextEditingController courseStartController = TextEditingController();
  TextEditingController courseEndController = TextEditingController();

  @observable
  bool loading = false;

  @observable
  int? courseId;

  @observable
  bool imageLoading = false;

  CourseApi courseApi = CourseApi();

  @action
  Future<void> saveCourse() async {
    loading = true;
    Course course = _loadCourse();
    await courseApi.saveCourse(course).whenComplete(() => loading = false);
  }

  Course _loadCourse() {
    return Course(
        location: courseLocationController.text,
        title: courseTitleController.text,
        description: courseDescriptionController.text,
        status: courseStatus,
        //start: courseStart != null ? fomDateTimeToMMYYYY(courseStart!) : null,
        // end: courseEnd != null ? fomDateTimeToMMYYYY(courseEnd!) : null);
        start: courseStartController.text,
        end: courseEndController.text);
  }

  @action
  Future<void> updateCourse() async {
    loading = true;
    Course course = _loadCourse();
    await courseApi.updateCourse(courseId: courseId!, course: course).whenComplete(() => loading = false);
  }

  @action
  Future<void> deleteCourse(int courseId) async {
    await courseApi.deleteCourse(courseId);
  }

  @action
  loadForm(Course course) {
    courseLocationController.text = course.location!;
    courseTitleController.text = course.title!;
    courseStartController.text = course.start!;
    courseEndController.text = course.end!;
    courseStatus = course.status;
    courseDescriptionController.text = course.description!;
    courseId = course.id;
  }

  @action
  reset() {
    courseLocationController = TextEditingController();
    courseTitleController = TextEditingController();
    courseStartController = TextEditingController();
    courseEndController = TextEditingController();
    courseStatus = null;
    courseDescriptionController = TextEditingController();
    loading = false;
    courseId = null;
    imageLoading = false;
  }
}
