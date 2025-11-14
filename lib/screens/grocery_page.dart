import 'package:flutter/material.dart';
import '../components/banner_slider.dart';
import '../components/app_footer.dart';
import '../components/header.dart';
import '../components/location_picker.dart';
import 'add_address_page.dart';
import 'wishlist_page.dart';

class GroceryPage extends StatefulWidget {
  final String selectedCity;
  final bool isFoodActive;
  final VoidCallback? onFoodTap;
  final VoidCallback? onGroceryTap;
  final Function(String)? onCitySelected;
  final VoidCallback? onWishlistTap;

  const GroceryPage({
    super.key,
    required this.selectedCity,
    required this.isFoodActive,
    this.onFoodTap,
    this.onGroceryTap,
    this.onCitySelected,
    this.onWishlistTap,
  });

  @override
  State<GroceryPage> createState() => _GroceryPageState();
}

class _GroceryPageState extends State<GroceryPage> {
  String _selectedFilter = 'All';
  final ScrollController _scrollController = ScrollController();
  final int _wishlistCount = 5; // Static wishlist count

  final List<String> _groceryFilters = [
    'All',
    'Fruits & Vegetables',
    'Dairy & Eggs',
    'Beverages',
    'Snacks & Sweets',
    'Grains & Pulses',
    'Frozen Foods',
    'Personal Care',
    'Household Items'
  ];

  final List<Map<String, dynamic>> _groceryStores = [
    // Fruits & Vegetables
    {
      'id': 'g1',
      'name': 'Fresh Mart',
      'category': 'Fruits & Vegetables',
      'rating': 4.5,
      'deliveryTime': '20 min',
      'deliveryFee': 25,
      'imageUrl': 'https://images.unsplash.com/photo-1556910103-1c02745aae4d?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': 'g2',
      'name': 'Green Grocers',
      'category': 'Fruits & Vegetables',
      'rating': 4.6,
      'deliveryTime': '18 min',
      'deliveryFee': 22,
      'imageUrl': 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    // Dairy & Eggs
    {
      'id': 'g3',
      'name': 'Super Market',
      'category': 'Dairy & Eggs',
      'rating': 4.4,
      'deliveryTime': '25 min',
      'deliveryFee': 30,
      'imageUrl': 'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': 'g4',
      'name': 'Daily Needs Store',
      'category': 'Dairy & Eggs',
      'rating': 4.6,
      'deliveryTime': '18 min',
      'deliveryFee': 22,
      'imageUrl': 'https://images.unsplash.com/photo-1604719312566-8912a92235c6?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    // Beverages
    {
      'id': 'g5',
      'name': 'Quick Grocery',
      'category': 'Beverages',
      'rating': 4.3,
      'deliveryTime': '15 min',
      'deliveryFee': 20,
      'imageUrl': 'https://images.unsplash.com/photo-1586511925558-a4c8d0bc6b81?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': 'g6',
      'name': 'City Mart',
      'category': 'Beverages',
      'rating': 4.5,
      'deliveryTime': '20 min',
      'deliveryFee': 25,
      'imageUrl': 'https://images.unsplash.com/photo-1604719312566-8912a92235c6?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    // Snacks & Sweets
    {
      'id': 'g7',
      'name': 'Organic Grocery',
      'category': 'Snacks & Sweets',
      'rating': 4.7,
      'deliveryTime': '22 min',
      'deliveryFee': 28,
      'imageUrl': 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': 'g8',
      'name': 'Mega Store',
      'category': 'Snacks & Sweets',
      'rating': 4.4,
      'deliveryTime': '25 min',
      'deliveryFee': 30,
      'imageUrl': 'https://images.unsplash.com/photo-1556910103-1c02745aae4d?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    // Grains & Pulses
    {
      'id': 'g9',
      'name': 'Grain Hub',
      'category': 'Grains & Pulses',
      'rating': 4.5,
      'deliveryTime': '20 min',
      'deliveryFee': 25,
      'imageUrl': 'https://images.unsplash.com/photo-1586511925558-a4c8d0bc6b81?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': 'g10',
      'name': 'Pulse Store',
      'category': 'Grains & Pulses',
      'rating': 4.3,
      'deliveryTime': '18 min',
      'deliveryFee': 22,
      'imageUrl': 'https://images.unsplash.com/photo-1604719312566-8912a92235c6?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    // Frozen Foods
    {
      'id': 'g11',
      'name': 'Frozen Express',
      'category': 'Frozen Foods',
      'rating': 4.6,
      'deliveryTime': '15 min',
      'deliveryFee': 20,
      'imageUrl': 'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': 'g12',
      'name': 'Cold Storage',
      'category': 'Frozen Foods',
      'rating': 4.4,
      'deliveryTime': '22 min',
      'deliveryFee': 28,
      'imageUrl': 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    // Personal Care
    {
      'id': 'g13',
      'name': 'Care Mart',
      'category': 'Personal Care',
      'rating': 4.5,
      'deliveryTime': '20 min',
      'deliveryFee': 25,
      'imageUrl': 'https://images.unsplash.com/photo-1556910103-1c02745aae4d?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': 'g14',
      'name': 'Wellness Store',
      'category': 'Personal Care',
      'rating': 4.7,
      'deliveryTime': '25 min',
      'deliveryFee': 30,
      'imageUrl': 'https://images.unsplash.com/photo-1586511925558-a4c8d0bc6b81?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    // Household Items
    {
      'id': 'g15',
      'name': 'Home Essentials',
      'category': 'Household Items',
      'rating': 4.4,
      'deliveryTime': '18 min',
      'deliveryFee': 22,
      'imageUrl': 'https://images.unsplash.com/photo-1604719312566-8912a92235c6?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': 'g16',
      'name': 'House Mart',
      'category': 'Household Items',
      'rating': 4.6,
      'deliveryTime': '20 min',
      'deliveryFee': 25,
      'imageUrl': 'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=400&h=300&fit=crop',
      'isOpen': true,
    },
  ];

  List<Map<String, dynamic>> get _filteredGroceryStores {
    if (_selectedFilter == 'All') {
      return _groceryStores;
    }
    return _groceryStores.where((store) => store['category'] == _selectedFilter).toList();
  }

  IconData _getFilterIcon(String filter) {
    switch (filter) {
      case 'All':
        return Icons.store;
      case 'Fruits & Vegetables':
        return Icons.apple;
      case 'Dairy & Eggs':
        return Icons.egg;
      case 'Beverages':
        return Icons.local_drink;
      case 'Snacks & Sweets':
        return Icons.cookie;
      case 'Grains & Pulses':
        return Icons.grain;
      case 'Frozen Foods':
        return Icons.ac_unit;
      case 'Personal Care':
        return Icons.spa;
      case 'Household Items':
        return Icons.home;
      default:
        return Icons.store;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        // App Bar with Toggle, Location, and Wishlist
        SliverAppBar(
          pinned: true,
          floating: false,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const SizedBox(width: 0),
          leadingWidth: 0,
          flexibleSpace: CustomHeader(
            scaffoldKey: GlobalKey<ScaffoldState>(),
            location: widget.selectedCity,
            isFoodActive: widget.isFoodActive,
            onFoodTap: widget.onFoodTap,
            onGroceryTap: widget.onGroceryTap,
            onLocationTap: () {
              LocationPicker.show(
                context: context,
                currentCity: widget.selectedCity,
                onCitySelected: (city) {
                  widget.onCitySelected?.call(city);
                },
                onAddAddress: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddAddressPage(),
                    ),
                  );
                  
                  if (result != null && result is Map<String, dynamic>) {
                    widget.onCitySelected?.call(result['address'] ?? widget.selectedCity);
                  }
                },
              );
            },
            onWishlistTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WishlistPage(),
                ),
              );
            },
            wishlistCount: _wishlistCount,
            onCartTap: () {
              // Navigate to cart
            },
          ),
        ),

        // Search Bar
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search grocery items, stores...',
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
          ),
        ),

        // Banner Slider
        const SliverToBoxAdapter(
          child: BannerSlider(),
        ),

        // Sticky Tabs
        SliverPersistentHeader(
          pinned: true,
          delegate: _StickyHeaderDelegate(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: _groceryFilters.length,
                itemBuilder: (context, index) {
                  final filter = _groceryFilters[index];
                  final isSelected = _selectedFilter == filter;
                  return GestureDetector(
                    onTap: () {
                      if (_selectedFilter != filter) {
                        setState(() {
                          _selectedFilter = filter;
                        });
                        _scrollController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.green.shade700 : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                        border: isSelected
                            ? Border.all(color: Colors.green.shade800, width: 1.5)
                            : Border.all(color: Colors.transparent, width: 0),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: Colors.green.withValues(alpha: 0.4),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _getFilterIcon(filter),
                            color: isSelected ? Colors.white : Colors.grey.shade700,
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            filter,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.grey.shade700,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),

        // Popular Grocery Stores
        if (_filteredGroceryStores.isNotEmpty)
          SliverToBoxAdapter(
            child: _buildSectionHeader('Popular Grocery Stores'),
          ),
        if (_filteredGroceryStores.isNotEmpty)
          SliverToBoxAdapter(
            child: SizedBox(
              height: screenHeight * 0.28,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                itemCount: _filteredGroceryStores.length > 5 ? 5 : _filteredGroceryStores.length,
                itemBuilder: (context, index) {
                  return _buildGrocerySliderCard(_filteredGroceryStores[index], screenWidth, screenHeight);
                },
              ),
            ),
          ),

        // Top Rated Grocery Stores
        if (_filteredGroceryStores.isNotEmpty)
          SliverToBoxAdapter(
            child: _buildSectionHeader('Top Rated Stores'),
          ),
        if (_filteredGroceryStores.isNotEmpty)
          SliverToBoxAdapter(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: _filteredGroceryStores.length > 10 ? 10 : _filteredGroceryStores.length,
              itemBuilder: (context, index) {
                return _buildGroceryListCard(_filteredGroceryStores[index], screenWidth);
              },
            ),
          ),

        // Footer
        const SliverToBoxAdapter(
          child: AppFooter(),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.045,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrocerySliderCard(Map<String, dynamic> store, double screenWidth, double screenHeight) {
    final cardWidth = screenWidth * 0.65;
    final sliderHeight = screenHeight * 0.28;
    final imageHeight = sliderHeight * 0.6;

    return Container(
      width: cardWidth,
      height: sliderHeight,
      margin: const EdgeInsets.only(right: 12),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              store['imageUrl'] as String,
              width: cardWidth,
              height: imageHeight,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  width: cardWidth,
                  height: imageHeight,
                  color: Colors.grey.shade200,
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: cardWidth,
                  height: imageHeight,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.store, size: 50, color: Colors.grey),
                );
              },
            ),
          ),
          // Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Store Name
                  Flexible(
                    flex: 1,
                    child: Text(
                      store['name'] as String,
                      style: TextStyle(
                        fontSize: screenWidth * 0.037,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Category
                  Flexible(
                    flex: 1,
                    child: Text(
                      store['category'] as String,
                      style: TextStyle(
                        fontSize: screenWidth * 0.030,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Spacer(),
                  // Rating and Delivery Info
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star, color: Colors.green.shade700, size: 11),
                              const SizedBox(width: 2),
                              Flexible(
                                child: Text(
                                  store['rating'].toString(),
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.026,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green.shade700,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          '${store['deliveryTime']} • ₹${store['deliveryFee']}',
                          style: TextStyle(
                            fontSize: screenWidth * 0.028,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroceryListCard(Map<String, dynamic> store, double screenWidth) {
    final imageSize = screenWidth * 0.25;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              store['imageUrl'] as String,
              width: imageSize,
              height: imageSize,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  width: imageSize,
                  height: imageSize,
                  color: Colors.grey.shade200,
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: imageSize,
                  height: imageSize,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.store, size: 30, color: Colors.grey),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  store['name'] as String,
                  style: TextStyle(
                    fontSize: screenWidth * 0.042,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  store['category'] as String,
                  style: TextStyle(
                    fontSize: screenWidth * 0.034,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, color: Colors.green.shade700, size: 12),
                          const SizedBox(width: 2),
                          Text(
                            store['rating'].toString(),
                            style: TextStyle(
                              fontSize: screenWidth * 0.030,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${store['deliveryTime']}',
                      style: TextStyle(
                        fontSize: screenWidth * 0.032,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '₹${store['deliveryFee']}',
                      style: TextStyle(
                        fontSize: screenWidth * 0.032,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _StickyHeaderDelegate({required this.child});

  @override
  double get minExtent => 50;

  @override
  double get maxExtent => 50;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_StickyHeaderDelegate oldDelegate) {
    return false;
  }
}

