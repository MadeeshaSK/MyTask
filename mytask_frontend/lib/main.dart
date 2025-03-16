import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mytask_frontend/services/notifications-services.dart';
import 'package:mytask_frontend/splash_screen.dart';
import 'package:mytask_frontend/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

Future _handlleBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print('Message handled in the background!');
  }
}

String? token = ''; // nullable

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Request permissions for notifications
  NotificationServices().requestPermissions();
  NotificationServices().initNotifications();

  await FirebaseMessaging.instance.getToken().then((value) {
    print('Token: $value');
    token = value;
  });

  FirebaseMessaging.onMessage.listen((event) async {
    NotificationServices().showNotification(event);
    await NotificationServices().saveNotification(
      event.notification!.title!,
      event.notification!.body!,
    );
  });

  // Handle messages in the background
  FirebaseMessaging.onBackgroundMessage(_handlleBackgroundMessage);

  // Handle messages when the app is in the foreground
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      print('Message handled in the foreground!');
    }
  });

  runApp(MyApp(notificationToken: token!));
}

class MyApp extends StatelessWidget {
  final String notificationToken;
  const MyApp({super.key, required this.notificationToken});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, //Remove Debug Banner top right on screen
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SplashScreen(fcmToken: notificationToken),
    );
  }
}
