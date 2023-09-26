import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsHelper {
  NotificationsHelper._();

  static final NotificationsHelper notificationsHelper =
      NotificationsHelper._();

  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  //
  // simpleNotifications({
  //   required int id,
  //   required String title,
  //   required String subTitle,
  // }) {
  //   AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails(
  //     "$id",
  //     "Chat App",
  //     importance: Importance.high,
  //     priority: Priority.high,
  //   );
  //
  //   DarwinNotificationDetails darwinNotificationDetails =
  //       DarwinNotificationDetails(
  //     subtitle: subTitle,
  //   );
  //
  //   flutterLocalNotificationsPlugin
  //       .show(
  //     id,
  //     title,
  //     subTitle,
  //     NotificationDetails(
  //       android: androidNotificationDetails,
  //       iOS: darwinNotificationDetails,
  //     ),
  //   )
  //       .then((value) {
  //     log("Notifications Showed");
  //   }).catchError((error) {
  //     log("Error : $error");
  //   });
  // }
}
