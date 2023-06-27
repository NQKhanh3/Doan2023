import 'package:da_tn_2023_appthongbao/ui/noctification_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotifyHelper{
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=
  FlutterLocalNotificationsPlugin();

  Future<void> initNotifi()async{
    AndroidInitializationSettings androidInitializationSettings =
    const AndroidInitializationSettings('app_icon');
    var initializationSetingIOS=DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestCriticalPermission: true,
      onDidReceiveLocalNotification: 
      (int id,String? title,String? body,String? payload)async { 
      });
    var initializationSeting= InitializationSettings(
      android: androidInitializationSettings,iOS: initializationSetingIOS
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSeting,
      onDidReceiveNotificationResponse:(NotificationResponse notificationResponse)async{});
    
  }

  noctificationDetail(){
    return const NotificationDetails(
      android: AndroidNotificationDetails('channelId', 'channelName',
      importance: Importance.max,
      icon: 'app_icon',
      ),
      iOS: DarwinNotificationDetails()
    );
  
  }
  Future ShowNotification({
    int id=0,String? title,String? body,String? payload
  })async{
    return flutterLocalNotificationsPlugin.show(id, title, body, await noctificationDetail());
  }



 
}