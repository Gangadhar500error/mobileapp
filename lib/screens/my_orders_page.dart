import 'package:flutter/material.dart';
import 'order_history_page.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildOrderOption(
            context,
            icon: Icons.history,
            title: 'Order History',
            subtitle: 'View all your past orders',
            color: Colors.blue,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OrderHistoryPage()),
              );
            },
          ),
          const SizedBox(height: 12),
          _buildOrderOption(
            context,
            icon: Icons.schedule,
            title: 'Active Orders',
            subtitle: 'Track your current orders',
            color: Colors.orange,
            onTap: () {
              // Navigate to active orders
            },
          ),
          const SizedBox(height: 12),
          _buildOrderOption(
            context,
            icon: Icons.repeat,
            title: 'Repeat Order',
            subtitle: 'Reorder from your history',
            color: Colors.purple,
            onTap: () {
              // Navigate to repeat order
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOrderOption(BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
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
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
        onTap: onTap,
      ),
    );
  }
}

