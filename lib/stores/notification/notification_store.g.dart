// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NotificationStore on _NotificationStore, Store {
  final _$loadingAtom = Atom(name: '_NotificationStore.loading');

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

  final _$imageLoadingAtom = Atom(name: '_NotificationStore.imageLoading');

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

  final _$notificationsAtom = Atom(name: '_NotificationStore.notifications');

  @override
  List<NotificationMessage>? get notifications {
    _$notificationsAtom.reportRead();
    return super.notifications;
  }

  @override
  set notifications(List<NotificationMessage>? value) {
    _$notificationsAtom.reportWrite(value, super.notifications, () {
      super.notifications = value;
    });
  }

  final _$notificationCountAtom =
      Atom(name: '_NotificationStore.notificationCount');

  @override
  int? get notificationCount {
    _$notificationCountAtom.reportRead();
    return super.notificationCount;
  }

  @override
  set notificationCount(int? value) {
    _$notificationCountAtom.reportWrite(value, super.notificationCount, () {
      super.notificationCount = value;
    });
  }

  final _$findNotificationsAsyncAction =
      AsyncAction('_NotificationStore.findNotifications');

  @override
  Future findNotifications() {
    return _$findNotificationsAsyncAction.run(() => super.findNotifications());
  }

  final _$countNotificationsUnreadAsyncAction =
      AsyncAction('_NotificationStore.countNotificationsUnread');

  @override
  Future countNotificationsUnread() {
    return _$countNotificationsUnreadAsyncAction
        .run(() => super.countNotificationsUnread());
  }

  final _$markAsReadAsyncAction = AsyncAction('_NotificationStore.markAsRead');

  @override
  Future markAsRead() {
    return _$markAsReadAsyncAction.run(() => super.markAsRead());
  }

  final _$deleteNotificationAsyncAction =
      AsyncAction('_NotificationStore.deleteNotification');

  @override
  Future deleteNotification(int id) {
    return _$deleteNotificationAsyncAction
        .run(() => super.deleteNotification(id));
  }

  @override
  String toString() {
    return '''
loading: ${loading},
imageLoading: ${imageLoading},
notifications: ${notifications},
notificationCount: ${notificationCount}
    ''';
  }
}
