import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mytask_frontend/models/notification_model.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationServices {
  List<NotificationModel> notifications = [];

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> requestPermissions() async {
    PermissionStatus permissionStatus = await Permission.notification.status;
    if (permissionStatus != PermissionStatus.granted) {
      throw 'Permission not granted';
    }
  }

  showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          'channelId',
          'channelName',
          channelDescription: 'channelDescription',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
        );
    int notificationID = 1;
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.show(
      notificationID,
      message.notification!.title,
      message.notification!.body,
      notificationDetails,
      payload: 'Not Precent',
    );
  }

  //save notification
  Future<void> saveNotification(String? title, String? body) async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .collection('Notifications')
          .doc()
          .set({'title': title, 'body': body, 'isRead': false});
    } catch (e) {
      print('Error saving notification: $e');
    }
  }

  // Fetch all notifications
  Future<void> getAllNotifications() async {
    notifications.clear();
    QuerySnapshot notificationSnapshot =
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('Notifications')
            .get();

    for (var notification in notificationSnapshot.docs) {
      NotificationModel notificationModel = NotificationModel(
        title: notification['title'],
        description: notification['body'],
        isRead: notification['isRead'],
        id: notification.id.toString(),
      );
      notifications.add(notificationModel);
    }
  }
}
