import 'dart:async';

import 'package:etiqaa/screens/accountSettings.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../models/child.dart';
import '../screens/alertDetails.dart';

class NotificationApi {
  // final StreamController didReceiveLocalNotificationStream =
  //   StreamController.broadcast();

  static final StreamController<String?> selectNotificationStream =
      StreamController<String?>.broadcast();

  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final BehaviorSubject<String?> onNotificatonClick =
      BehaviorSubject<String?>();
  Future<void> initNotification() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings settings =
        InitializationSettings(android: androidInitializationSettings);

    await notificationsPlugin.initialize(settings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) {
      print('payload: $notificationResponse.payload');
      // Get.off(accountSettings());
      // Get.off(
      //   AlertDetails(
      //       name: 'meme',
      //       date: '12',
      //       sender: 'haya',
      //       content: 'hello hello',
      //       gender: Gender.Boy,
      //       isSaved: true,
      //       id: 1),
      // );
      selectNotificationStream.add(notificationResponse.payload);
    }
        // onDidReceiveNotificationResponse: (payload) async {
        //   onNotificatonClick.add(payload.toString());
        //   print('payload: $payload');
        // },
        );
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channel_id', 'channel_name',
            importance: Importance.max, playSound: true));
  }

  Future showNotification(
      {int id = 0,
      required String title,
      required String body,
      required String payload}) async {
    return notificationsPlugin
        .show(id, title, body, await notificationDetails(), payload: payload);
  }

  // void onSelectNotification(String? payload) {
  //   print('payload $payload');
  //   if (payload != null && payload.isNotEmpty) {
  //     onNotificatonClick.add(payload);
  //   }
  // }
}
