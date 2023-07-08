import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class FirebaseNotify {
final _firebaseMessaging =FirebaseMessaging.instance;
   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=
  FlutterLocalNotificationsPlugin();

    void initializationLocalNotify(BuildContext context, RemoteMessage Message)async{
      var  androidInitializationSettings =const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSetingIOS= const  DarwinInitializationSettings();


      var initializationSeting= InitializationSettings(
      android: androidInitializationSettings,
      iOS: initializationSetingIOS
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSeting,
      onDidReceiveNotificationResponse:(payload){

      });
    
    }

    void requestNotifyPermission()async{
      NotificationSettings settings =await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true
      );
      if(settings.authorizationStatus==AuthorizationStatus.authorized){
        print('user granted');
      }else if(settings.authorizationStatus==AuthorizationStatus.provisional){
        print('user granted');
      }else{
        print('user granted Permission');
      }
    }

    void firebaseInit(){
      FirebaseMessaging.onMessage.listen((event) {
        print(event.notification!.title.toString());
         print(event.notification!.body.toString());
         ShowNotification(event);
      });
    }

    Future<void> ShowNotification(RemoteMessage message)async{
      
      AndroidNotificationChannel channel=AndroidNotificationChannel(
       Random.secure().nextInt(10000).toString(),' channelName No');
      
      AndroidNotificationDetails androidNotificationDetails=AndroidNotificationDetails(
        channel.id.toString(),
        channel.name.toString(),
         icon: '@mipmap/ic_launcher',
         
         );

         DarwinNotificationDetails darwinNotificationDetails =DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true 

         );

         NotificationDetails notificationDetails =NotificationDetails(
          android: androidNotificationDetails,
          
          iOS: darwinNotificationDetails
         );


      Future.delayed(Duration.zero, (){
      flutterLocalNotificationsPlugin.show(
        0,
       message.notification!.title.toString(),
         message.notification!.body.toString(),
         notificationDetails);
    });
    }

    Future<String> getDeviceToken()async{
      String? token = await _firebaseMessaging.getToken();
     return token!;
    }

    void isTokenrefresh()async{

      _firebaseMessaging.onTokenRefresh.listen((event) {
        event.toString();
      });
    
    }
    void getTopic(String? value)async{
     
      _firebaseMessaging.subscribeToTopic(value.toString());

    }
    // ignore: non_constant_identifier_names
    void UnsubscribeToTopic(String? value)async{
     
      _firebaseMessaging.unsubscribeFromTopic(value.toString());

    }

}
