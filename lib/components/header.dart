import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final int cartItemCount;
  final VoidCallback? onCartTap;
  final String location;
  final bool isFoodActive;
  final VoidCallback? onFoodTap;
  final VoidCallback? onGroceryTap;
  final VoidCallback? onLocationTap;
  final VoidCallback? onWishlistTap;
  final int wishlistCount;

  const CustomHeader({
    super.key,
    required this.scaffoldKey,
    this.cartItemCount = 0,
    this.onCartTap,
    this.location = '123 Main Street',
    this.isFoodActive = true,
    this.onFoodTap,
    this.onGroceryTap,
    this.onLocationTap,
    this.onWishlistTap,
    this.wishlistCount = 0,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: const SizedBox(width: 0),
      leadingWidth: 0,
      title: Row(
        children: [
          // Location - Left side end
          GestureDetector(
            onTap: onLocationTap,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 150),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      color: Colors.red.shade600,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        location,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.grey.shade600,
                      size: 14,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Food/Grocery Toggle - Center
          Expanded(
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: onFoodTap,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: isFoodActive ? Colors.green.shade700 : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.restaurant,
                              color: isFoodActive ? Colors.white : Colors.grey.shade700,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Food',
                              style: TextStyle(
                                color: isFoodActive ? Colors.white : Colors.grey.shade700,
                                fontWeight: isFoodActive ? FontWeight.bold : FontWeight.normal,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: onGroceryTap,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: !isFoodActive ? Colors.green.shade700 : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.shopping_cart,
                              color: !isFoodActive ? Colors.white : Colors.grey.shade700,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Grocery',
                              style: TextStyle(
                                color: !isFoodActive ? Colors.white : Colors.grey.shade700,
                                fontWeight: !isFoodActive ? FontWeight.bold : FontWeight.normal,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        Stack(
          children: [
            IconButton(
              icon: Icon(Icons.favorite_border, color: Colors.grey.shade800),
              onPressed: onWishlistTap ?? () {},
            ),
            if (wishlistCount > 0)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red.shade600,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: Center(
                    child: Text(
                      wishlistCount > 99 ? '99+' : '$wishlistCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

