import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:newprojectfirebase/signup_screen.dart';
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
  @override
  void initState() {
    super.initState();
   checkPermissions();
   getnotifications();
   getFCMToken();
  }

 FirebaseMessaging messaging = FirebaseMessaging.instance;//for making it a global variable

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

  void getnotifications(){
   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  print('Got a message whilst in the foreground!');
  print('Message data: ${message.data}');

  if (message.notification != null) {
    print('Message also contained a notification: ${message.notification}');
  }
});
  }

  void getFCMToken() async {
    String? token = await messaging.getToken();
    print("FCM Token: $token");
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
        home: const SignUpScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
