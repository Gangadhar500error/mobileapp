import 'package:flutter/material.dart';

enum ActiveTab { food, grocery, milk }

class CustomHeader extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final int cartItemCount;
  final VoidCallback? onCartTap;
  final String location;
  final VoidCallback? onLocationTap;
  final VoidCallback? onWishlistTap;
  final int wishlistCount;

  const CustomHeader({
    super.key,
    required this.scaffoldKey,
    this.cartItemCount = 0,
    this.onCartTap,
    this.location = '123 Main Street',
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
      title: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = MediaQuery.of(context).size.width;
          final isSmallScreen = screenWidth < 400;
          final locationMaxWidth = isSmallScreen ? 140.0 : 160.0;
          
          return Row(
            children: [
              // Location - Left side
              Expanded(
                child: GestureDetector(
                  onTap: onLocationTap,
                  child: Container(
                    constraints: BoxConstraints(maxWidth: locationMaxWidth),
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 8 : 10,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F9FC),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey.withValues(alpha: 0.2),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200.withValues(alpha: 0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          color: Colors.red.shade600,
                          size: isSmallScreen ? 16 : 18,
                        ),
                        SizedBox(width: isSmallScreen ? 6 : 8),
                        Flexible(
                          child: Text(
                            location,
                            style: TextStyle(
                              color: const Color(0xFF2B2B2B),
                              fontSize: isSmallScreen ? 12 : 13,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        SizedBox(width: isSmallScreen ? 4 : 6),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Colors.grey.shade600,
                          size: isSmallScreen ? 16 : 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          );
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                icon: Icon(
                  Icons.favorite_border_rounded,
                  color: Colors.grey.shade800,
                  size: 22,
                ),
                onPressed: onWishlistTap ?? () {},
              ),
              if (wishlistCount > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red.shade600,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.shade600.withValues(alpha: 0.4),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 20,
                      minHeight: 20,
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
        ),
      ],
    );
  }
}
