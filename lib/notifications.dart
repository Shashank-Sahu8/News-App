import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';




class NotificationServices{
  final FlutterLocalNotificationsPlugin notificationsPlugin=FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings androidInitializationSettings=const AndroidInitializationSettings('user');

  void initialNotification()async{
    InitializationSettings initializationSettings=InitializationSettings(
      android: androidInitializationSettings
    );
    notificationsPlugin.initialize(initializationSettings);
  }

  void sendNotification()async{
    AndroidNotificationDetails androidNotificationDetails=AndroidNotificationDetails("channelId", "channelName",importance: Importance.max,priority: Priority.max);
    NotificationDetails notificationDetails=NotificationDetails(android: androidNotificationDetails);

    await notificationsPlugin.show(
        0,
        'title',
        'body',
        notificationDetails);
  }
}