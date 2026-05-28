import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/greenhouse/presentation/providers/notification_provider.dart';
import '../../features/greenhouse/data/models/notification_model.dart';

// Xử lý background message (phải là top-level function)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("Handling a background message: ${message.messageId}");

  if (message.notification != null) {
    // Lưu thông báo vào SharedPreferences (chạy độc lập trong background isolate)
    final prefs = await SharedPreferences.getInstance();
    List<String> storedData = prefs.getStringList('notifications') ?? [];

    final newNotif = NotificationModel(
      id: message.messageId ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: message.notification!.title ?? 'Thông báo',
      body: message.notification!.body ?? '',
      timestamp: DateTime.now(),
    );

    // Thêm vào đầu list
    storedData.insert(0, newNotif.toJson());

    // Giữ tối đa 50 cái
    if (storedData.length > 50) {
      storedData = storedData.sublist(0, 50);
    }

    await prefs.setStringList('notifications', storedData);
  }
}

class FCMService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    // 1. Cấu hình background handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // 2. Xin quyền nhận thông báo (đặc biệt quan trọng trên iOS và Android 13+)
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );
    debugPrint('User granted permission: ${settings.authorizationStatus}');

    // 3. Khởi tạo Local Notifications để hiện khi đang mở App (Foreground)
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await _localNotificationsPlugin.initialize(settings: initializationSettings);

    // 4. Lấy FCM Token và lưu lên Realtime Database
    try {
      String? token = await _messaging.getToken();
      if (token != null) {
        debugPrint("FCM Token: $token");
        await _saveTokenToDatabase(token);
      }
    } catch (e) {
      debugPrint("Error getting FCM token: $e");
    }

    // 5. Cập nhật token nếu nó thay đổi
    _messaging.onTokenRefresh.listen(_saveTokenToDatabase);

    // 6. Xử lý thông báo khi app đang mở (Foreground)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Got a message whilst in the foreground!');
      debugPrint('Message data: ${message.data}');

      if (message.notification != null) {
        debugPrint(
            'Message also contained a notification: ${message.notification}');
        _showLocalNotification(message.notification!);
        
        // Lưu thông báo vào Provider để hiện trên giao diện
        NotificationProvider.instance.addNotification(
          NotificationModel(
            id: message.messageId ?? DateTime.now().millisecondsSinceEpoch.toString(),
            title: message.notification!.title ?? 'Thông báo',
            body: message.notification!.body ?? '',
            timestamp: DateTime.now(),
          ),
        );
      }
    });
  }

  Future<void> _saveTokenToDatabase(String token) async {
    // Lưu token vào node /fcmTokens trên Firebase Realtime Database
    await _database.ref('fcmTokens').child(token).set(true);
  }

  void _showLocalNotification(RemoteNotification notification) {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'high_importance_channel', // id
      'High Importance Notifications', // name
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    _localNotificationsPlugin.show(
      id: notification.hashCode,
      title: notification.title,
      body: notification.body,
      notificationDetails: platformChannelSpecifics,
    );
  }
}
