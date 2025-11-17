import 'package:flutter/material.dart';
import '../components/banner_slider.dart';
import '../components/app_footer.dart';
import '../components/header.dart';
import '../components/category_tabs.dart';
import '../components/filter_tabs.dart';
import '../components/location_picker.dart';
import 'add_address_page.dart';
import 'wishlist_page.dart';

class MilkPage extends StatefulWidget {
  final String selectedCity;
  final ActiveTab activeTab;
  final VoidCallback? onFoodTap;
  final VoidCallback? onGroceryTap;
  final VoidCallback? onMilkTap;
  final Function(String)? onCitySelected;
  final VoidCallback? onWishlistTap;

  const MilkPage({
    super.key,
    required this.selectedCity,
    required this.activeTab,
    this.onFoodTap,
    this.onGroceryTap,
    this.onMilkTap,
    this.onCitySelected,
    this.onWishlistTap,
  });

  @override
  State<MilkPage> createState() => _MilkPageState();
}

class _MilkPageState extends State<MilkPage> {
  String _selectedFilter = 'All';
  final ScrollController _scrollController = ScrollController();
  final int _wishlistCount = 5;

  final List<String> _milkFilters = [
    'All',
    'Fresh Milk',
    'Flavored Milk',
    'Curd & Yogurt',
    'Butter & Ghee',
    'Cheese',
    'Paneer',
    'Milk Products',
    'Organic Milk'
  ];

  final List<Map<String, dynamic>> _milkStores = [
    // Fresh Milk
    {
      'id': 'm1',
      'name': 'Fresh Dairy Farm',
      'category': 'Fresh Milk',
      'rating': 4.8,
      'deliveryTime': '15 min',
      'deliveryFee': 20,
      'imageUrl': 'https://images.unsplash.com/photo-1563636619-e9143da7973b?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': 'm2',
      'name': 'Daily Milk Supply',
      'category': 'Fresh Milk',
      'rating': 4.7,
      'deliveryTime': '12 min',
      'deliveryFee': 18,
      'imageUrl': 'https://images.unsplash.com/photo-1563636619-e9143da7973b?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': 'm3',
      'name': 'Pure Milk Center',
      'category': 'Fresh Milk',
      'rating': 4.6,
      'deliveryTime': '18 min',
      'deliveryFee': 22,
      'imageUrl': 'https://images.unsplash.com/photo-1563636619-e9143da7973b?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    // Flavored Milk
    {
      'id': 'm4',
      'name': 'Milk Shake Hub',
      'category': 'Flavored Milk',
      'rating': 4.5,
      'deliveryTime': '20 min',
      'deliveryFee': 25,
      'imageUrl': 'https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': 'm5',
      'name': 'Flavor Delight',
      'category': 'Flavored Milk',
      'rating': 4.4,
      'deliveryTime': '22 min',
      'deliveryFee': 28,
      'imageUrl': 'https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    // Curd & Yogurt
    {
      'id': 'm6',
      'name': 'Yogurt Express',
      'category': 'Curd & Yogurt',
      'rating': 4.7,
      'deliveryTime': '16 min',
      'deliveryFee': 20,
      'imageUrl': 'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': 'm7',
      'name': 'Fresh Curd House',
      'category': 'Curd & Yogurt',
      'rating': 4.6,
      'deliveryTime': '14 min',
      'deliveryFee': 18,
      'imageUrl': 'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    // Butter & Ghee
    {
      'id': 'm8',
      'name': 'Ghee Specialists',
      'category': 'Butter & Ghee',
      'rating': 4.8,
      'deliveryTime': '25 min',
      'deliveryFee': 30,
      'imageUrl': 'https://images.unsplash.com/photo-1603532648955-039310d9ed75?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': 'm9',
      'name': 'Pure Ghee Store',
      'category': 'Butter & Ghee',
      'rating': 4.7,
      'deliveryTime': '20 min',
      'deliveryFee': 25,
      'imageUrl': 'https://images.unsplash.com/photo-1603532648955-039310d9ed75?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    // Cheese
    {
      'id': 'm10',
      'name': 'Cheese Corner',
      'category': 'Cheese',
      'rating': 4.5,
      'deliveryTime': '18 min',
      'deliveryFee': 22,
      'imageUrl': 'https://images.unsplash.com/photo-1486297678162-eb2a19b0a32d?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    // Paneer
    {
      'id': 'm11',
      'name': 'Fresh Paneer House',
      'category': 'Paneer',
      'rating': 4.6,
      'deliveryTime': '15 min',
      'deliveryFee': 20,
      'imageUrl': 'https://images.unsplash.com/photo-1603532648955-039310d9ed75?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': 'm12',
      'name': 'Paneer Express',
      'category': 'Paneer',
      'rating': 4.5,
      'deliveryTime': '17 min',
      'deliveryFee': 22,
      'imageUrl': 'https://images.unsplash.com/photo-1603532648955-039310d9ed75?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    // Milk Products
    {
      'id': 'm13',
      'name': 'Dairy Products Hub',
      'category': 'Milk Products',
      'rating': 4.7,
      'deliveryTime': '20 min',
      'deliveryFee': 25,
      'imageUrl': 'https://images.unsplash.com/photo-1563636619-e9143da7973b?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    // Organic Milk
    {
      'id': 'm14',
      'name': 'Organic Dairy Farm',
      'category': 'Organic Milk',
      'rating': 4.8,
      'deliveryTime': '22 min',
      'deliveryFee': 28,
      'imageUrl': 'https://images.unsplash.com/photo-1563636619-e9143da7973b?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': 'm15',
      'name': 'Pure Organic Milk',
      'category': 'Organic Milk',
      'rating': 4.6,
      'deliveryTime': '25 min',
      'deliveryFee': 30,
      'imageUrl': 'https://images.unsplash.com/photo-1563636619-e9143da7973b?w=400&h=300&fit=crop',
      'isOpen': true,
    },
  ];

  List<Map<String, dynamic>> get _filteredMilkStores {
    if (_selectedFilter == 'All') {
      return _milkStores;
    }
    return _milkStores.where((store) => store['category'] == _selectedFilter).toList();
  }

  IconData _getFilterIcon(String filter) {
    switch (filter) {
      case 'All':
        return Icons.local_drink;
      case 'Fresh Milk':
        return Icons.water_drop;
      case 'Flavored Milk':
        return Icons.local_bar;
      case 'Curd & Yogurt':
        return Icons.restaurant;
      case 'Butter & Ghee':
        return Icons.circle;
      case 'Cheese':
        return Icons.square;
      case 'Paneer':
        return Icons.crop_square;
      case 'Milk Products':
        return Icons.shopping_bag;
      case 'Organic Milk':
        return Icons.eco;
      default:
        return Icons.local_drink;
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
            onCartTap: () {},
          ),
        ),

        // Category Tabs (Food/Grocery/Milk) - Hide on scroll
        SliverPersistentHeader(
          pinned: false,
          delegate: _StickyHeaderDelegate(
            height: 60,
            child: CategoryTabs(
              activeTab: widget.activeTab,
              onFoodTap: widget.onFoodTap,
              onGroceryTap: widget.onGroceryTap,
              onMilkTap: widget.onMilkTap,
            ),
          ),
        ),

        // Search Bar
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FC),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search milk products, stores...',
                  hintStyle: TextStyle(color: Colors.grey.withValues(alpha: 0.6)),
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
          child: BannerSlider(category: ActiveTab.milk),
        ),

        // Filter Tabs (All, Fresh Milk, etc.) - Sticky
        SliverPersistentHeader(
          pinned: true,
          delegate: _StickyHeaderDelegate(
            height: 60,
            child: FilterTabs(
              filters: _milkFilters,
              selectedFilter: _selectedFilter,
              onFilterTap: (filter) {
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
              getFilterIcon: _getFilterIcon,
            ),
          ),
        ),

        // Popular Milk Stores
        if (_filteredMilkStores.isNotEmpty)
          SliverToBoxAdapter(
            child: _buildSectionHeader('Popular Milk Stores'),
          ),
        if (_filteredMilkStores.isNotEmpty)
          SliverToBoxAdapter(
            child: SizedBox(
              height: screenHeight * 0.28,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                itemCount: _filteredMilkStores.length > 5 ? 5 : _filteredMilkStores.length,
                itemBuilder: (context, index) {
                  return _buildMilkSliderCard(_filteredMilkStores[index], screenWidth, screenHeight);
                },
              ),
            ),
          ),

        // Top Rated Milk Stores
        if (_filteredMilkStores.isNotEmpty)
          SliverToBoxAdapter(
            child: _buildSectionHeader('Top Rated Stores'),
          ),
        if (_filteredMilkStores.isNotEmpty)
          SliverToBoxAdapter(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: _filteredMilkStores.length > 10 ? 10 : _filteredMilkStores.length,
              itemBuilder: (context, index) {
                return _buildMilkListCard(_filteredMilkStores[index], screenWidth);
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
              color: const Color(0xFF2B2B2B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMilkSliderCard(Map<String, dynamic> store, double screenWidth, double screenHeight) {
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
                  child: const Icon(Icons.local_drink, size: 50, color: Colors.grey),
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
                        color: const Color(0xFF2B2B2B),
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
                            color: const Color(0xFF0A3D91).withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star, color: const Color(0xFF0A3D91), size: 11),
                              const SizedBox(width: 2),
                              Flexible(
                                child: Text(
                                  store['rating'].toString(),
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.026,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF0A3D91),
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

  Widget _buildMilkListCard(Map<String, dynamic> store, double screenWidth) {
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
                  child: const Icon(Icons.local_drink, size: 30, color: Colors.grey),
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
                    color: const Color(0xFF2B2B2B),
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
                        color: const Color(0xFF0A3D91).withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, color: const Color(0xFF0A3D91), size: 12),
                          const SizedBox(width: 2),
                          Text(
                            store['rating'].toString(),
                            style: TextStyle(
                              fontSize: screenWidth * 0.030,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF0A3D91),
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
  final double height;

  _StickyHeaderDelegate({required this.child, this.height = 120});

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_StickyHeaderDelegate oldDelegate) {
    return child != oldDelegate.child || height != oldDelegate.height;
  }
}

