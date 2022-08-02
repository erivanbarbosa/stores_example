import 'package:redesprou_boilerplate_name/data/database/pushnotification_dao.dart';
import 'package:redesprou_boilerplate_name/data/network/apis/notification/notification_api.dart';
import 'package:mobx/mobx.dart';
import 'package:redesprou_boilerplate_name/models/notification/notification.dart';

part 'notification_store.g.dart';

class NotificationStore = _NotificationStore with _$NotificationStore;

abstract class _NotificationStore with Store {
  @observable
  bool loading = false;

  @observable
  bool imageLoading = false;

  @observable
  List<NotificationMessage>? notifications = [];

  @observable
  int? notificationCount;

  NotificationApi _notificationApi = NotificationApi();

  PushNotificationDao dao = PushNotificationDao();

  @action
  findNotifications() async {
    List<NotificationMessage> notifications = await dao.getRawTable().whenComplete(() => loading = false);
    this.notifications = notifications;
    print(notifications);
  }

  @action
  countNotificationsUnread() async {
    int count = await dao.getCountUnreads();
    this.notificationCount = count;
  }

  @action
  markAsRead() async {
    await dao.updateAsRead();
    countNotificationsUnread();
  }

  @action
  deleteNotification(int id) async {
    await dao.delete(id);
    findNotifications();
  }
}
