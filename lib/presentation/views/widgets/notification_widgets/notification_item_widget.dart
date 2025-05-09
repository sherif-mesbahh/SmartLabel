import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationItem extends StatelessWidget {
  final String? message;
  final DateTime? createdAt;

  const NotificationItem({
    super.key,
    this.message,
    this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = createdAt != null
        ? DateFormat('yyyy-MM-dd – HH:mm').format(createdAt!)
        : 'Unknown date';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.notifications, color: Colors.blue),
        title:
            Text(message ?? 'No message', style: const TextStyle(fontSize: 16)),
        subtitle: Text(formattedDate,
            style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ),
    );
  }
}
