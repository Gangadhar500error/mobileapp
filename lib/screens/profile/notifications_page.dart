import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {'title': 'Order #1234 delivered', 'time': '2 hours ago', 'read': false},
      {'title': 'New offer: 50% off on first order', 'time': '1 day ago', 'read': false},
      {'title': 'Weekly summary available', 'time': '2 days ago', 'read': true},
      {'title': 'Payment received ₹250', 'time': '3 days ago', 'read': true},
      {'title': 'Profile verification completed', 'time': '5 days ago', 'read': true},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: const Color(0xFF0A3D91),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: (notification['read'] as bool)
                    ? Colors.grey.shade200
                    : const Color(0xFF0A3D91).withValues(alpha: 0.1),
                child: Icon(
                  Icons.notifications,
                  color: (notification['read'] as bool)
                      ? Colors.grey.shade600
                      : const Color(0xFF0A3D91),
                ),
              ),
              title: Text(
                notification['title'] as String,
                style: TextStyle(
                  fontWeight: (notification['read'] as bool)
                      ? FontWeight.normal
                      : FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              subtitle: Text(
                notification['time'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              trailing: (notification['read'] as bool)
                  ? null
                  : Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFF0A3D91),
                        shape: BoxShape.circle,
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}

