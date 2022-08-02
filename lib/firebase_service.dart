/* import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:redesprou_boilerplate_name/data/database/pushnotification_dao.dart';
import 'package:redesprou_boilerplate_name/data/network/apis/common/common_api.dart';
import 'package:redesprou_boilerplate_name/models/notification/notification.dart';
import 'package:redesprou_boilerplate_name/stores/notification/notification_store.dart';
import 'package:redesprou_boilerplate_name/utils/date_utils.dart';
import 'package:redesprou_boilerplate_name/utils/string_utils.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;

configureFirebase() async {
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  messaging.getToken().then((token) {
    print('\n******\nFirebase Token $token\n******\n');
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('---------------- Got a message whilst in the foreground! --------------------');
    _handleNotification(message);

    if (message.notification != null) {
      print('-------------- Message also contained a notification: ${message.notification} -----------------');
    }
  });

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();
    _handleNotification(message);
    print("Handling a background message: ${message.messageId}");
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

void _handleNotification(RemoteMessage message) async {
  NotificationMessage notification = NotificationMessage(
      createdAt: message.sentTime != null ? fromDateTimeToYYYYMMDD(message.sentTime!) : null,
      title: message.notification != null ? message.notification!.title : "",
      body: message.notification != null ? message.notification!.body : "",
      read: 'UNREAD');

  PushNotificationDao dao = PushNotificationDao();
  await dao.insert(notification.toMap());
  NotificationStore notificationStore = Get.find();
  notificationStore.countNotificationsUnread();
}

saveFirebaseToken() {
  CommonApi commonApi = CommonApi();
  messaging.getToken().then((token) {
    if (isNotBlank(token)) {
      commonApi.saveToken(token!);
    }
  });
}
 */