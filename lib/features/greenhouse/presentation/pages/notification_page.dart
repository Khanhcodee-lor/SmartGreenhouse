import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/notification_provider.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();
    // Đánh dấu tất cả là đã đọc khi vừa mở trang
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotificationProvider>().markAllAsRead();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F5),
      appBar: AppBar(
        title: const Text('Thông báo'),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep_rounded),
            onPressed: () {
              _showClearConfirmDialog(context);
            },
            tooltip: 'Xóa tất cả',
          ),
        ],
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF43A047)),
            );
          }

          if (provider.notifications.isEmpty) {
            return _buildEmptyState();
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            itemCount: provider.notifications.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final notif = provider.notifications[index];
              return _buildNotificationCard(notif);
            },
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(10),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.notifications_off_outlined,
              size: 64,
              color: Color(0xFFC8E6C9),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Chưa có thông báo nào',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2E3A46),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Mọi cảnh báo từ nhà kính sẽ hiện ở đây',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF8E9EAB),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(dynamic notif) {
    // Phân loại icon dựa theo tiêu đề
    IconData iconData = Icons.notifications_rounded;
    Color iconColor = const Color(0xFF43A047);
    Color bgColor = const Color(0xFFE8F5E9);

    final titleLower = notif.title.toString().toLowerCase();
    if (titleLower.contains('nhiệt độ')) {
      if (titleLower.contains('cao') || titleLower.contains('nóng')) {
        iconData = Icons.local_fire_department_rounded;
        iconColor = const Color(0xFFEF5350);
        bgColor = Colors.red.shade50;
      } else {
        iconData = Icons.ac_unit_rounded;
        iconColor = const Color(0xFF42A5F5);
        bgColor = Colors.blue.shade50;
      }
    } else if (titleLower.contains('máy bơm')) {
      iconData = Icons.water_drop_rounded;
      iconColor = const Color(0xFF29B6F6);
      bgColor = Colors.lightBlue.shade50;
    } else if (titleLower.contains('kết nối') || titleLower.contains('lỗi')) {
      iconData = Icons.warning_amber_rounded;
      iconColor = Colors.orange;
      bgColor = Colors.orange.shade50;
    } else if (titleLower.contains('khôi phục')) {
      iconData = Icons.check_circle_outline_rounded;
      iconColor = const Color(0xFF43A047);
      bgColor = const Color(0xFFE8F5E9);
    } else if (titleLower.contains('đất')) {
      iconData = Icons.grass_rounded;
      iconColor = const Color(0xFF8D6E63);
      bgColor = Colors.brown.shade50;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(8),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: bgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(iconData, color: iconColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          notif.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2E3A46),
                          ),
                        ),
                      ),
                      Text(
                        DateFormat('HH:mm').format(notif.timestamp),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF8E9EAB),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    notif.body,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF5F6D7A),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    DateFormat('dd/MM/yyyy').format(notif.timestamp),
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFFB0BEC5),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showClearConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Xóa tất cả?'),
        content: const Text('Bạn có chắc muốn xóa toàn bộ lịch sử thông báo?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Hủy', style: TextStyle(color: Color(0xFF8E9EAB))),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<NotificationProvider>().clearAll();
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade400,
              foregroundColor: Colors.white,
              elevation: 0,
            ),
            child: const Text('Xóa hết'),
          ),
        ],
      ),
    );
  }
}
