import 'package:flutter/material.dart';

class BestOffersPage extends StatelessWidget {
  const BestOffersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> offers = [
      {
        'id': '1',
        'title': '50% OFF',
        'subtitle': 'On your first order',
        'restaurant': 'Pizza Palace',
        'imageUrl': 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400&h=300&fit=crop',
        'validUntil': 'Valid until Dec 31, 2024',
        'code': 'FIRST50',
      },
      {
        'id': '2',
        'title': 'Free Delivery',
        'subtitle': 'On orders above ₹300',
        'restaurant': 'Burger King',
        'imageUrl': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400&h=300&fit=crop',
        'validUntil': 'Valid until Dec 25, 2024',
        'code': 'FREEDEL',
      },
      {
        'id': '3',
        'title': 'Buy 2 Get 1 Free',
        'subtitle': 'On selected items',
        'restaurant': 'Sushi House',
        'imageUrl': 'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=400&h=300&fit=crop',
        'validUntil': 'Valid until Dec 20, 2024',
        'code': 'B2G1',
      },
      {
        'id': '4',
        'title': 'Weekend Special',
        'subtitle': 'Extra 20% off this weekend',
        'restaurant': 'Taco Bell',
        'imageUrl': 'https://images.unsplash.com/photo-1565299585323-38174c3b1c5e?w=400&h=300&fit=crop',
        'validUntil': 'Valid until Dec 22, 2024',
        'code': 'WEEKEND20',
      },
      {
        'id': '5',
        'title': 'Flat ₹100 OFF',
        'subtitle': 'On orders above ₹500',
        'restaurant': 'Pasta Corner',
        'imageUrl': 'https://images.unsplash.com/photo-1551183053-bf91a1d81141?w=400&h=300&fit=crop',
        'validUntil': 'Valid until Dec 30, 2024',
        'code': 'FLAT100',
      },
      {
        'id': '6',
        'title': 'Combo Deal',
        'subtitle': 'Pizza + Coke at ₹299',
        'restaurant': 'Pizza Palace',
        'imageUrl': 'https://images.unsplash.com/photo-1628840042765-356cda07504e?w=400&h=300&fit=crop',
        'validUntil': 'Valid until Dec 28, 2024',
        'code': 'COMBO299',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Best Offers'),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: offers.length,
        itemBuilder: (context, index) {
          final offer = offers[index];
          return _buildOfferCard(context, offer);
        },
      ),
    );
  }

  Widget _buildOfferCard(BuildContext context, Map<String, dynamic> offer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Offer Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Stack(
              children: [
                Image.network(
                  offer['imageUrl'] as String,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.local_offer, size: 50, color: Colors.grey),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 200,
                      color: Colors.grey.shade100,
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                ),
                // Offer Badge
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade600,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      offer['code'] as String,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            offer['title'] as String,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            offer['subtitle'] as String,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.restaurant, size: 16, color: Colors.grey.shade600),
                    const SizedBox(width: 4),
                    Text(
                      offer['restaurant'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.access_time, size: 16, color: Colors.grey.shade600),
                    const SizedBox(width: 4),
                    Text(
                      offer['validUntil'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to restaurant or apply offer
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Offer ${offer['code']} applied!'),
                          backgroundColor: Colors.green.shade700,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Use Offer',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

