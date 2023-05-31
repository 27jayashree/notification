
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static void initilize()
  {
    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"),
        iOS: IOSInitializationSettings());


    _notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload)
        {
          //print(payload);
        });
  }

  static void showNotificationOnForeground(RemoteMessage message) {

    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();

    final notificationDetail = NotificationDetails(
        android: AndroidNotificationDetails(
          "com.example.notificationexample",
          "flutter_app_push_notification",
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          icon: '@mipmap/ic_launcher'),
        iOS: iOSPlatformChannelSpecifics);

    _notificationsPlugin.show(
      DateTime.now().microsecond,
      message.notification!.title,
      message.notification!.body,
      notificationDetail,
      payload: message.data["message"],
    );
  }

}
