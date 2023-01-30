import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'screen_worker/setting_w.dart';
import 'user/login.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  final Rxn<RemoteMessage> message = Rxn<RemoteMessage>();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  const channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  var initialzationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);


  var initializationSettings =
      InitializationSettings(android: initialzationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

  runApp(const MyApp());

  final token = await FirebaseMessaging.instance.getToken();
  print("token : ${token ?? 'token NULL!'}");
  // return token;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  void initState() {

    FirebaseMessaging.onMessage.listen((RemoteMessage rm) async {
      // message.value = rm;
      RemoteNotification? notification = rm.notification;
      AndroidNotification? android = rm.notification?.android;

      var androidNotiDetails = AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
      );

      //var iOSNotiDetails = const IOSNotificationDetails();
      var details = NotificationDetails(android: androidNotiDetails);
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          0,
          //notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel', // AndroidNotificationChannel()에서 생성한 ID
              'High Importance Notifications',
                channelDescription:
                'This channel is used for important notifications.'
              // other properties...
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print(message);
      //super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'BM Hanna Pro',
          primarySwatch: Colors.blue,
        ),
        //test
        home: login()
        //
        );
  }
}
