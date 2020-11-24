import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class LocalNotifyManager{
   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
   var initializationSettings;
   BehaviorSubject<ReceiveNotification> get didLReceiveLocalNotificationSubject =>
   BehaviorSubject<ReceiveNotification>();


   LocalNotifyManager.init(){
     flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();

     if(Platform.isIOS){
       requestIOSPermission();
     }
     initializePlatform();
   }

   requestIOSPermission(){
     flutterLocalNotificationsPlugin
         .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
         .requestPermissions(
       alert: true,
       badge: true,
       sound: true
     );
   }
   requestAndroidPermission(){

   }
   initializePlatform(){
     var initializationSettingsAndroid =
     AndroidInitializationSettings('app_icon');
     var initializationSettingsIOS = IOSInitializationSettings(
         requestAlertPermission: true,
         requestBadgePermission: true,
         requestSoundPermission: true,
         onDidReceiveLocalNotification:
             (int id, String title, String body, String payload) async {
               ReceiveNotification notification=
                   ReceiveNotification(id: id,body: body,title: title,payload: payload);
               didLReceiveLocalNotificationSubject.add(notification);

             });
      initializationSettings = InitializationSettings(
        android:  initializationSettingsAndroid,iOS:  initializationSettingsIOS);


      }
   setOnNotificationReceive(Function onNotificationReceive){
     didLReceiveLocalNotificationSubject.listen((notification) {
       onNotificationReceive(notification);
     });
   }
   setOnNotificationClick(Function onNotificationClick) async{
     await flutterLocalNotificationsPlugin.initialize(
         initializationSettings,onSelectNotification: (String payload)async{
       onNotificationClick(payload);
     });
   }
   Future<void> showNotification()async{
     var androidChannel = AndroidNotificationDetails(
         'CHANNEL_ID','CHANNEL_NAME','CHANNEL_DESCRIPTION',
       importance: Importance.max,
       priority: Priority.high,
         icon: 'app_icon',
         sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
         largeIcon: DrawableResourceAndroidBitmap('app_icon'),
       playSound: true,
       timeoutAfter: 5000,
       enableLights: true,
       enableVibration: true,
       color: Colors.teal

     );
     var iosChannel = IOSNotificationDetails(/*sound: 'a_long_cold_sting'*/);
     var platfromChannel = NotificationDetails(android: androidChannel,iOS: iosChannel);
     await flutterLocalNotificationsPlugin.show(
         0,
         'Test Title','Test Body', platfromChannel,payload: 'New Payload');
   }

   Future<void> scheduledNotification({DateTime scheduleTime,String body,String title,int id})async{
   //  var scheduleTime = DateTime.now().add(Duration(seconds: 10));
     var androidChannel = AndroidNotificationDetails(
         'CHANNEL_ID','CHANNEL_NAME','CHANNEL_DESCRIPTION',
         importance: Importance.max,
         priority: Priority.high,
        icon: 'app_icon',
         sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
         largeIcon: DrawableResourceAndroidBitmap('app_icon'),
         playSound: true,
     //   timeoutAfter: 5000,
         enableLights: true,
         enableVibration: true,
     );
     var iosChannel = IOSNotificationDetails(/*sound: 'a_long_cold_sting'*/);
     var platfromChannel = NotificationDetails(android: androidChannel,iOS: iosChannel);
     await flutterLocalNotificationsPlugin.schedule(
         id,
         title,body,scheduleTime, platfromChannel,payload: 'New Payload');
   }
   Future<void> repeatNotification({String body,String title,int id})async{
     var androidChannel = AndroidNotificationDetails(
       'CHANNEL_ID','CHANNEL_NAME','CHANNEL_DESCRIPTION',
       importance: Importance.max,
       priority: Priority.high,
       icon: 'app_notification_icon',


       sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
       largeIcon: DrawableResourceAndroidBitmap('app_notification_icon'),
       playSound: true,
      // timeoutAfter: 2000,
       enableLights: true,
       enableVibration: true,


     );
     var iosChannel = IOSNotificationDetails(/*sound: 'a_long_cold_sting'*/);
     var platfromChannel = NotificationDetails(android: androidChannel,iOS: iosChannel);
     await flutterLocalNotificationsPlugin.periodicallyShow(
         id,
         title,body,RepeatInterval.everyMinute, platfromChannel,payload: 'New Payload');
   }
   Future<void> showDailyAtTimeNotification()async{
     var time=Time(3,10,10);
     var androidChannel = AndroidNotificationDetails(
         'CHANNEL_ID 1','CHANNEL_NAME 1','CHANNEL_DESCRIPTION 1',
         importance: Importance.max,
         priority: Priority.high,
         icon: 'app_notification_icon',
         sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
         largeIcon: DrawableResourceAndroidBitmap('app_notification_large'),
         playSound: true,
         timeoutAfter: 5000,
         enableLights: true,
         enableVibration: true,
         color: Colors.teal

     );
     var iosChannel = IOSNotificationDetails(/*sound: 'a_long_cold_sting'*/);
     var platfromChannel = NotificationDetails(android: androidChannel,iOS: iosChannel);
     await flutterLocalNotificationsPlugin.showDailyAtTime(
         0,
         'Daily Title${time.hour},${time.minute}','Test Body', time,platfromChannel,payload: 'New Payload');
   }

   Future<void> cancelNotification(int id)async{
     await flutterLocalNotificationsPlugin.cancel(id);
   }
   Future<void>cancelAllNotification()async{
     await flutterLocalNotificationsPlugin.cancelAll();
   }
}

LocalNotifyManager localNotifyManager=LocalNotifyManager.init();
class ReceiveNotification{
 final int id;
 final String title;
 final String body;
 final String payload;
 ReceiveNotification({this.id,this.title,this.body,this.payload});

}
