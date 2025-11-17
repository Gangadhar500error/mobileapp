import 'package:flutter/material.dart';
import 'header.dart';

class TabSection extends StatelessWidget {
  final ActiveTab activeTab;
  final VoidCallback? onFoodTap;
  final VoidCallback? onGroceryTap;
  final VoidCallback? onMilkTap;
  final List<String> filters;
  final String selectedFilter;
  final Function(String)? onFilterTap;
  final IconData Function(String)? getFilterIcon;

  const TabSection({
    super.key,
    required this.activeTab,
    this.onFoodTap,
    this.onGroceryTap,
    this.onMilkTap,
    required this.filters,
    required this.selectedFilter,
    this.onFilterTap,
    this.getFilterIcon,
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

  Widget _buildFilterChip(String filter, bool isSelected) {
    return Builder(
      builder: (context) {
        final screenWidth = MediaQuery.of(context).size.width;
        final isSmallScreen = screenWidth < 400;
        
        IconData? icon;
        if (getFilterIcon != null) {
          icon = getFilterIcon!(filter);
        }
        
        return GestureDetector(
          onTap: () => onFilterTap?.call(filter),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            margin: EdgeInsets.only(right: isSmallScreen ? 8 : 10),
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 12 : 16,
              vertical: isSmallScreen ? 8 : 10,
            ),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF0A3D91) : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected 
                    ? const Color(0xFF0A3D91) 
                    : Colors.grey.shade300,
                width: isSelected ? 2 : 1,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: const Color(0xFF0A3D91).withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: Colors.grey.shade200.withValues(alpha: 0.4),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Container(
                    width: isSmallScreen ? 20 : 24,
                    height: isSmallScreen ? 20 : 24,
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? Colors.white.withValues(alpha: 0.2) 
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      icon,
                      size: isSmallScreen ? 14 : 16,
                      color: isSelected ? Colors.white : Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(width: isSmallScreen ? 6 : 8),
                ],
                Text(
                  filter,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey.shade700,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                    fontSize: isSmallScreen ? 12 : 13,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 125,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Tabs (Food/Grocery/Milk)
          Container(
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
          ),
          
          // Filter Tabs (Scrollable)
          SizedBox(
            height: 60,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: filters.map((filter) {
                  return _buildFilterChip(
                    filter,
                    selectedFilter == filter,
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

