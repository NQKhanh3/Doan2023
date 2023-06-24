import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotifyHelper{
    FlutterLocalNotificationsPlugin
    flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin(); //

  initializeNotification() async {
    //tz.initializeTimeZones();
   // this is for latest iOS settings
    final DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
       
    );

 final AndroidInitializationSettings initializationSettingsAndroid =
     AndroidInitializationSettings('appicon');

    final InitializationSettings initializationSettings =
        InitializationSettings(
       iOS: initializationSettingsIOS,
       android:initializationSettingsAndroid,
    ); 
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
       );
  
  }
  void SendNotification(String title, String body)async{
    AndroidNotificationDetails androidNotificationDetails=
    AndroidNotificationDetails(
      "channelId",
       "channelName",
       importance: Importance.max,
       priority: Priority.high
    );

    NotificationDetails notificationDetails =NotificationDetails();
   await flutterLocalNotificationsPlugin.show(0, title, body, notificationDetails);
  }
}