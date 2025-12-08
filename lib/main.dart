import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:newprojectfirebase/forgot_password.dart';
import 'package:newprojectfirebase/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:newprojectfirebase/firebase_options.dart';
import 'package:newprojectfirebase/features/providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    checkPermissions();
    initializeLocalNotification();
    getNotifications();
    getFCMToken();
  }

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  void checkPermissions() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }

  void getNotifications() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showSimpleNotification(
        message.notification?.title ?? "",
        message.notification?.body ?? "",
      );
    });
  }

  void getFCMToken() async {
    String? token = await messaging.getToken();
    print("FCM Token: $token");
  }

  void initializeLocalNotification() {
    // Small icon must be drawable (white)
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/yatra');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void showSimpleNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',

      // Small icon (white) from drawable
      icon: '@drawable/yatra',

      // Optional large icon (full color) from mipmap
      largeIcon: DrawableResourceAndroidBitmap('yatra'),
    );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Google Sign In Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const ForgotPassword(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
