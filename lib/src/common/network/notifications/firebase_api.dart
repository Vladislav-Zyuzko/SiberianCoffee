import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:siberian_coffee/src/store/api/sc_preferencies_api.dart';


class FirebaseApi {
  final IScPreferenciesApi _scSharedPreferenciesApi;
  final _firebaseMessaging = FirebaseMessaging.instance;

  FirebaseApi({required IScPreferenciesApi scSharedPreferenciesApi}) 
  : _scSharedPreferenciesApi = scSharedPreferenciesApi;

  final _androidChannel = const AndroidNotificationChannel(
    'high importance_channel',
    'High Importance Notifications',
    importance: Importance.defaultImportance,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    try {
      await _firebaseMessaging.requestPermission(provisional: true,);
      final String fCMToken = await _firebaseMessaging.getToken() ?? '';
      _scSharedPreferenciesApi.saveFcmToken(fcmToken: fCMToken);
      initPushNotifications();
      initLocalNotifications();
    } on FirebaseException catch(e, stackTrace) {
      debugPrint("FirebaseException: $e");
      debugPrint("Stack Trace: $stackTrace");
    } catch(e, stackTrace) {
      debugPrint("Error when using the package firebase_messaging: $e");
      debugPrint('Stack Trace: $stackTrace');
    }
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((message) {
      final RemoteNotification? notification = message.notification;
      final AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidChannel.id,
              _androidChannel.name,
            ),
          ),
          payload: jsonEncode(message.toMap()),
        );
      }
    });
  }

  Future<void> initLocalNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);

    await _localNotifications.initialize(settings);

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }
}