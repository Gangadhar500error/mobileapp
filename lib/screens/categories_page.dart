import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        'name': 'Veg',
        'icon': Icons.eco,
        'color': const Color(0xFF0A3D91),
        'count': '120+',
      },
      {
        'name': 'Non-Veg',
        'icon': Icons.set_meal,
        'color': Colors.red,
        'count': '85+',
      },
      {
        'name': 'Pizza',
        'icon': Icons.local_pizza,
        'color': Colors.orange,
        'count': '45+',
      },
      {
        'name': 'Snacks',
        'icon': Icons.fastfood,
        'color': Colors.amber,
        'count': '90+',
      },
      {
        'name': 'Biryani',
        'icon': Icons.rice_bowl,
        'color': Colors.brown,
        'count': '35+',
      },
      {
        'name': 'Chinese',
        'icon': Icons.ramen_dining,
        'color': Colors.deepOrange,
        'count': '60+',
      },
      {
        'name': 'Italian',
        'icon': Icons.dinner_dining,
        'color': Colors.purple,
        'count': '40+',
      },
      {
        'name': 'Desserts',
        'icon': Icons.cake,
        'color': Colors.pink,
        'count': '55+',
      },
      {
        'name': 'Beverages',
        'icon': Icons.local_drink,
        'color': Colors.blue,
        'count': '70+',
      },
      {
        'name': 'Breakfast',
        'icon': Icons.breakfast_dining,
        'color': Colors.orange,
        'count': '50+',
      },
      {
        'name': 'South Indian',
        'icon': Icons.restaurant,
        'color': Colors.teal,
        'count': '65+',
      },
      {
        'name': 'North Indian',
        'icon': Icons.restaurant_menu,
        'color': Colors.indigo,
        'count': '75+',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        title: const Text(
          'Categories',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: Colors.grey.shade200,
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.1,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return _buildCategoryCard(
            context,
            category['name'] as String,
            category['icon'] as IconData,
            category['color'] as Color,
            category['count'] as String,
          );
        },
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    String name,
    IconData icon,
    Color color,
    String count,
  ) {
    return GestureDetector(
      onTap: () {
        // Navigate to category details or filter by category
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Showing $name items'),
            duration: const Duration(seconds: 1),
            backgroundColor: const Color(0xFF0A3D91),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.grey.shade200,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    color.withValues(alpha: 0.15),
                    color.withValues(alpha: 0.25),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 32,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              name,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                letterSpacing: 0.2,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$count items',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

