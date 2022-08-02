// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CourseStore on _CourseStore, Store {
  final _$loadingAtom = Atom(name: '_CourseStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$courseIdAtom = Atom(name: '_CourseStore.courseId');

  @override
  int? get courseId {
    _$courseIdAtom.reportRead();
    return super.courseId;
  }

  @override
  set courseId(int? value) {
    _$courseIdAtom.reportWrite(value, super.courseId, () {
      super.courseId = value;
    });
  }

  final _$imageLoadingAtom = Atom(name: '_CourseStore.imageLoading');

  @override
  bool get imageLoading {
    _$imageLoadingAtom.reportRead();
    return super.imageLoading;
  }

  @override
  set imageLoading(bool value) {
    _$imageLoadingAtom.reportWrite(value, super.imageLoading, () {
      super.imageLoading = value;
    });
  }

  final _$saveCourseAsyncAction = AsyncAction('_CourseStore.saveCourse');

  @override
  Future<void> saveCourse() {
    return _$saveCourseAsyncAction.run(() => super.saveCourse());
  }

  final _$updateCourseAsyncAction = AsyncAction('_CourseStore.updateCourse');

  @override
  Future<void> updateCourse() {
    return _$updateCourseAsyncAction.run(() => super.updateCourse());
  }

  final _$deleteCourseAsyncAction = AsyncAction('_CourseStore.deleteCourse');

  @override
  Future<void> deleteCourse(int courseId) {
    return _$deleteCourseAsyncAction.run(() => super.deleteCourse(courseId));
  }

  final _$_CourseStoreActionController = ActionController(name: '_CourseStore');

  @override
  dynamic loadForm(Course course) {
    final _$actionInfo = _$_CourseStoreActionController.startAction(
        name: '_CourseStore.loadForm');
    try {
      return super.loadForm(course);
    } finally {
      _$_CourseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic reset() {
    final _$actionInfo =
        _$_CourseStoreActionController.startAction(name: '_CourseStore.reset');
    try {
      return super.reset();
    } finally {
      _$_CourseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
courseId: ${courseId},
imageLoading: ${imageLoading}
    ''';
  }
}
