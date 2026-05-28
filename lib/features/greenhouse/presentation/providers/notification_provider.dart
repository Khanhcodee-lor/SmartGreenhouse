import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/notification_model.dart';

class NotificationProvider extends ChangeNotifier with WidgetsBindingObserver {
  static final NotificationProvider instance = NotificationProvider._internal();
  factory NotificationProvider() => instance;

  List<NotificationModel> _notifications = [];
  bool _isLoading = true;

  List<NotificationModel> get notifications => _notifications;
  bool get isLoading => _isLoading;
  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  NotificationProvider._internal() {
    _loadNotifications();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Khi app mở lại từ background, tải lại danh sách thông báo
      reload();
    }
  }

  Future<void> reload() async {
    await _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? storedData = prefs.getStringList('notifications');

    if (storedData != null) {
      _notifications = storedData
          .map((item) => NotificationModel.fromJson(item))
          .toList();
    }
    
    // Đảm bảo danh sách được sắp xếp mới nhất lên đầu
    _notifications.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> _saveNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> dataToSave =
        _notifications.map((item) => item.toJson()).toList();
    await prefs.setStringList('notifications', dataToSave);
  }

  Future<void> addNotification(NotificationModel notification) async {
    // Thêm vào đầu danh sách
    _notifications.insert(0, notification);
    
    // Giới hạn 50 thông báo gần nhất
    if (_notifications.length > 50) {
      _notifications = _notifications.sublist(0, 50);
    }
    
    await _saveNotifications();
    notifyListeners();
  }

  Future<void> markAllAsRead() async {
    bool changed = false;
    for (var notif in _notifications) {
      if (!notif.isRead) {
        notif.isRead = true;
        changed = true;
      }
    }
    
    if (changed) {
      await _saveNotifications();
      notifyListeners();
    }
  }

  Future<void> clearAll() async {
    _notifications.clear();
    await _saveNotifications();
    notifyListeners();
  }
}
