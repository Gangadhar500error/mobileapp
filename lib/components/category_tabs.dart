import 'package:flutter/material.dart';
import 'header.dart';

class CategoryTabs extends StatelessWidget {
  final ActiveTab activeTab;
  final VoidCallback? onFoodTap;
  final VoidCallback? onGroceryTap;
  final VoidCallback? onMilkTap;

  const CategoryTabs({
    super.key,
    required this.activeTab,
    this.onFoodTap,
    this.onGroceryTap,
    this.onMilkTap,
  });

  Widget _buildCategoryTabButton({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback? onTap,
  }) {
    return Builder(
      builder: (context) {
        final screenWidth = MediaQuery.of(context).size.width;
        final isSmallScreen = screenWidth < 400;
        final isVerySmallScreen = screenWidth < 360;
        
        return Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              margin: EdgeInsets.symmetric(horizontal: isVerySmallScreen ? 2 : 3),
              padding: EdgeInsets.symmetric(
                horizontal: isVerySmallScreen ? 6 : (isSmallScreen ? 8 : 10),
                vertical: isVerySmallScreen ? 8 : 10,
              ),
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFF0A3D91) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isActive 
                      ? const Color(0xFF0A3D91) 
                      : Colors.grey.shade300,
                  width: isActive ? 2 : 1,
                ),
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: const Color(0xFF0A3D91).withValues(alpha: 0.25),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.grey.shade200.withValues(alpha: 0.5),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    color: isActive ? Colors.white : Colors.grey.shade700,
                    size: isVerySmallScreen ? 16 : (isSmallScreen ? 18 : 20),
                  ),
                  SizedBox(width: isVerySmallScreen ? 4 : 6),
                  Flexible(
                    child: Text(
                      label,
                      style: TextStyle(
                        color: isActive ? Colors.white : Colors.grey.shade700,
                        fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
                        fontSize: isVerySmallScreen ? 11 : (isSmallScreen ? 12 : 13),
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200.withValues(alpha: 0.5),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildCategoryTabButton(
            icon: Icons.restaurant_rounded,
            label: 'Food',
            isActive: activeTab == ActiveTab.food,
            onTap: onFoodTap,
          ),
          _buildCategoryTabButton(
            icon: Icons.shopping_cart_rounded,
            label: 'Grocery',
            isActive: activeTab == ActiveTab.grocery,
            onTap: onGroceryTap,
          ),
          _buildCategoryTabButton(
            icon: Icons.local_drink_rounded,
            label: 'Dairy',
            isActive: activeTab == ActiveTab.milk,
            onTap: onMilkTap,
          ),
        ],
      ),
    );
  }
}

