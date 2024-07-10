// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';

import '../const_resource.dart';

class FirebaseMessageObject {
  late String type;
  late String typeId;

  static FirebaseMessageObject fromJson(Map<String, dynamic> data) {
    FirebaseMessageObject object = FirebaseMessageObject();
    object.type = data['type'];
    object.typeId = data['typeId'];
    return object;
  }
}

Future<void> initFCM() async {
  //request Permission to show notification
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // NotificationSettings settings = await messaging.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );

  await messaging.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );

  // print('User granted permission: ${settings.authorizationStatus}');

  //Get FCM Token
  fcmToken = await FirebaseMessaging.instance.getToken();
  print("FCM: " + fcmToken.toString());

  FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
    // TODO: If necessary send token to application server.

    // Note: This callback is fired at each app startup and whenever a new
    // token is generated.
  }).onError((err) {
    // Error getting token.
  });
}