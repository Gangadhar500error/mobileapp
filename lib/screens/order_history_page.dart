import 'package:flutter/material.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  final List<Map<String, dynamic>> _orders = [
    {
      'id': 'ORD001',
      'restaurant': 'Pizza Palace',
      'items': '2x Margherita Pizza, 1x Coke',
      'total': 647,
      'status': 'delivered',
      'date': '2024-01-15',
      'time': '14:30',
      'vendorAccepted': true,
      'acceptedAt': DateTime.now().subtract(const Duration(minutes: 10)),
    },
    {
      'id': 'ORD002',
      'restaurant': 'Burger King',
      'items': '1x Veg Burger, 1x Fries',
      'total': 248,
      'status': 'out_for_delivery',
      'date': '2024-01-16',
      'time': '12:15',
      'vendorAccepted': true,
      'acceptedAt': DateTime.now().subtract(const Duration(minutes: 3)),
    },
    {
      'id': 'ORD003',
      'restaurant': 'Sushi House',
      'items': '3x Sushi Rolls',
      'total': 1047,
      'status': 'accepted',
      'date': '2024-01-16',
      'time': '18:45',
      'vendorAccepted': true,
      'acceptedAt': DateTime.now().subtract(const Duration(minutes: 2)),
    },
    {
      'id': 'ORD004',
      'restaurant': 'Taco Bell',
      'items': '2x Tacos, 1x Nachos',
      'total': 398,
      'status': 'pending',
      'date': '2024-01-16',
      'time': '19:20',
      'vendorAccepted': false,
      'acceptedAt': null,
    },
  ];

  bool _canCancel(Map<String, dynamic> order) {
    if (order['status'] == 'delivered' || order['status'] == 'cancelled') {
      return false;
    }
    
    if (!order['vendorAccepted']) {
      return true; // Can cancel before vendor accepts
    }
    
    // Can cancel only within 5 minutes of vendor acceptance
    final acceptedAt = order['acceptedAt'] as DateTime?;
    if (acceptedAt != null) {
      final now = DateTime.now();
      final difference = now.difference(acceptedAt);
      return difference.inMinutes <= 5;
    }
    
    return false;
  }

  void _cancelOrder(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Order'),
        content: const Text('Are you sure you want to cancel this order?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                order['status'] = 'cancelled';
              });
              Navigator.pop(context);
              
              // Show notification
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Order cancelled. Notification sent to vendor.'),
                  backgroundColor: Colors.orange,
                ),
              );
            },
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'delivered':
        return const Color(0xFF0A3D91);
      case 'out_for_delivery':
        return Colors.blue;
      case 'accepted':
        return Colors.orange;
      case 'pending':
        return Colors.grey;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'delivered':
        return Icons.check_circle;
      case 'out_for_delivery':
        return Icons.delivery_dining;
      case 'accepted':
        return Icons.restaurant;
      case 'pending':
        return Icons.access_time;
      case 'cancelled':
        return Icons.cancel;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
        backgroundColor: const Color(0xFF0A3D91),
        foregroundColor: Colors.white,
      ),
      body: _orders.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, size: 80, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  Text(
                    'No orders yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _orders.length,
              itemBuilder: (context, index) {
                final order = _orders[index];
                final status = order['status'] as String;
                final statusColor = _getStatusColor(status);
                final canCancel = _canCancel(order);

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Order Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Order ${order['id']}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                order['restaurant'] as String,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: statusColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: statusColor),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(_getStatusIcon(status), size: 16, color: statusColor),
                                const SizedBox(width: 4),
                                Text(
                                  status.toUpperCase().replaceAll('_', ' '),
                                  style: TextStyle(
                                    color: statusColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 24),
                      
                      // Order Details
                      Text(
                        order['items'] as String,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${order['date']} at ${order['time']}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          Text(
                            '₹${order['total']}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF0A3D91),
                            ),
                          ),
                        ],
                      ),
                      
                      // Cancel Button
                      if (canCancel) ...[
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () => _cancelOrder(order),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.red,
                              side: const BorderSide(color: Colors.red),
                            ),
                            child: const Text('Cancel Order'),
                          ),
                        ),
                      ],
                      
                      // Cancellation Info
                      if (order['vendorAccepted'] && canCancel)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            'You can cancel within 5 minutes of vendor acceptance',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.orange.shade700,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

