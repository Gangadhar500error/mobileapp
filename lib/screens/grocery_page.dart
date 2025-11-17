import 'package:flutter/material.dart';
import '../components/banner_slider.dart';
import '../components/app_footer.dart';
import '../components/header.dart';
import '../components/category_tabs.dart';
import '../components/filter_tabs.dart';
import '../components/location_picker.dart';
import 'add_address_page.dart';
import 'wishlist_page.dart';

class GroceryPage extends StatefulWidget {
  final String selectedCity;
  final ActiveTab activeTab;
  final VoidCallback? onFoodTap;
  final VoidCallback? onGroceryTap;
  final VoidCallback? onMilkTap;
  final Function(String)? onCitySelected;
  final VoidCallback? onWishlistTap;

  const GroceryPage({
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
  State<GroceryPage> createState() => _GroceryPageState();
}

class _GroceryPageState extends State<GroceryPage> {
  String _selectedFilter = 'All';
  final ScrollController _scrollController = ScrollController();
  final int _wishlistCount = 5;

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
    {
      'id': 'g17',
      'name': 'Veggie Paradise',
      'category': 'Fruits & Vegetables',
      'rating': 4.7,
      'deliveryTime': '15 min',
      'deliveryFee': 20,
      'imageUrl': 'https://images.unsplash.com/photo-1610832958506-aa56368176cf?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': 'g18',
      'name': 'Farm Fresh',
      'category': 'Fruits & Vegetables',
      'rating': 4.8,
      'deliveryTime': '22 min',
      'deliveryFee': 28,
      'imageUrl': 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': 'g19',
      'name': 'Organic Veggies',
      'category': 'Fruits & Vegetables',
      'rating': 4.6,
      'deliveryTime': '25 min',
      'deliveryFee': 30,
      'imageUrl': 'https://images.unsplash.com/photo-1556910103-1c02745aae4d?w=400&h=300&fit=crop',
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
    {
      'id': 'g20',
      'name': 'Dairy Delight',
      'category': 'Dairy & Eggs',
      'rating': 4.7,
      'deliveryTime': '20 min',
      'deliveryFee': 25,
      'imageUrl': 'https://images.unsplash.com/photo-1550583724-b2692b85b150?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': 'g21',
      'name': 'Fresh Dairy Co',
      'category': 'Dairy & Eggs',
      'rating': 4.5,
      'deliveryTime': '16 min',
      'deliveryFee': 20,
      'imageUrl': 'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': 'g22',
      'name': 'Egg Express',
      'category': 'Dairy & Eggs',
      'rating': 4.6,
      'deliveryTime': '14 min',
      'deliveryFee': 18,
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
    {
      'id': 'g23',
      'name': 'Drink Hub',
      'category': 'Beverages',
      'rating': 4.4,
      'deliveryTime': '18 min',
      'deliveryFee': 22,
      'imageUrl': 'https://images.unsplash.com/photo-1586511925558-a4c8d0bc6b81?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': 'g24',
      'name': 'Beverage Express',
      'category': 'Beverages',
      'rating': 4.6,
      'deliveryTime': '12 min',
      'deliveryFee': 19,
      'imageUrl': 'https://images.unsplash.com/photo-1604719312566-8912a92235c6?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': 'g25',
      'name': 'Cool Drinks Store',
      'category': 'Beverages',
      'rating': 4.5,
      'deliveryTime': '16 min',
      'deliveryFee': 21,
      'imageUrl': 'https://images.unsplash.com/photo-1586511925558-a4c8d0bc6b81?w=400&h=300&fit=crop',
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
    {
      'id': 'g26',
      'name': 'Sweet Treats',
      'category': 'Snacks & Sweets',
      'rating': 4.8,
      'deliveryTime': '20 min',
      'deliveryFee': 26,
      'imageUrl': 'https://images.unsplash.com/photo-1603532648955-039310d9ed75?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': 'g27',
      'name': 'Snack Corner',
      'category': 'Snacks & Sweets',
      'rating': 4.5,
      'deliveryTime': '18 min',
      'deliveryFee': 24,
      'imageUrl': 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': 'g28',
      'name': 'Candy World',
      'category': 'Snacks & Sweets',
      'rating': 4.6,
      'deliveryTime': '15 min',
      'deliveryFee': 20,
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
    {
      'id': 'g29',
      'name': 'Grain Market',
      'category': 'Grains & Pulses',
      'rating': 4.6,
      'deliveryTime': '22 min',
      'deliveryFee': 27,
      'imageUrl': 'https://images.unsplash.com/photo-1586511925558-a4c8d0bc6b81?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': 'g30',
      'name': 'Pulse Paradise',
      'category': 'Grains & Pulses',
      'rating': 4.4,
      'deliveryTime': '19 min',
      'deliveryFee': 23,
      'imageUrl': 'https://images.unsplash.com/photo-1604719312566-8912a92235c6?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': 'g31',
      'name': 'Whole Grain Store',
      'category': 'Grains & Pulses',
      'rating': 4.7,
      'deliveryTime': '24 min',
      'deliveryFee': 29,
      'imageUrl': 'https://images.unsplash.com/photo-1586511925558-a4c8d0bc6b81?w=400&h=300&fit=crop',
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
    {
      'id': 'g32',
      'name': 'Ice Cold Foods',
      'category': 'Frozen Foods',
      'rating': 4.5,
      'deliveryTime': '18 min',
      'deliveryFee': 24,
      'imageUrl': 'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': 'g33',
      'name': 'Freeze Mart',
      'category': 'Frozen Foods',
      'rating': 4.7,
      'deliveryTime': '20 min',
      'deliveryFee': 26,
      'imageUrl': 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': 'g34',
      'name': 'Frozen Delights',
      'category': 'Frozen Foods',
      'rating': 4.6,
      'deliveryTime': '16 min',
      'deliveryFee': 22,
      'imageUrl': 'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=400&h=300&fit=crop',
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
    {
      'id': 'g35',
      'name': 'Beauty Care',
      'category': 'Personal Care',
      'rating': 4.6,
      'deliveryTime': '18 min',
      'deliveryFee': 23,
      'imageUrl': 'https://images.unsplash.com/photo-1556910103-1c02745aae4d?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': 'g36',
      'name': 'Health & Beauty',
      'category': 'Personal Care',
      'rating': 4.8,
      'deliveryTime': '22 min',
      'deliveryFee': 27,
      'imageUrl': 'https://images.unsplash.com/photo-1586511925558-a4c8d0bc6b81?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': 'g37',
      'name': 'Care Express',
      'category': 'Personal Care',
      'rating': 4.5,
      'deliveryTime': '16 min',
      'deliveryFee': 21,
      'imageUrl': 'https://images.unsplash.com/photo-1556910103-1c02745aae4d?w=400&h=300&fit=crop',
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
    {
      'id': 'g38',
      'name': 'Home Depot',
      'category': 'Household Items',
      'rating': 4.5,
      'deliveryTime': '19 min',
      'deliveryFee': 24,
      'imageUrl': 'https://images.unsplash.com/photo-1604719312566-8912a92235c6?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': 'g39',
      'name': 'Household Hub',
      'category': 'Household Items',
      'rating': 4.7,
      'deliveryTime': '21 min',
      'deliveryFee': 26,
      'imageUrl': 'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': 'g40',
      'name': 'Essential Store',
      'category': 'Household Items',
      'rating': 4.6,
      'deliveryTime': '17 min',
      'deliveryFee': 23,
      'imageUrl': 'https://images.unsplash.com/photo-1604719312566-8912a92235c6?w=400&h=300&fit=crop',
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

  IconData _getCategoryIcon(String category) {
    return _getFilterIcon(category);
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Fruits & Vegetables':
        return Colors.green;
      case 'Dairy & Eggs':
        return Colors.blue;
      case 'Beverages':
        return Colors.orange;
      case 'Snacks & Sweets':
        return Colors.pink;
      case 'Grains & Pulses':
        return Colors.brown;
      case 'Frozen Foods':
        return Colors.cyan;
      case 'Personal Care':
        return Colors.purple;
      case 'Household Items':
        return Colors.indigo;
      default:
        return const Color(0xFF0A3D91);
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
            onCartTap: () {
              // Navigate to cart
            },
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
          child: BannerSlider(category: ActiveTab.grocery),
        ),

        // Filter Tabs (All, Fruits & Vegetables, etc.) - Sticky
        SliverPersistentHeader(
          pinned: true,
          delegate: _StickyHeaderDelegate(
            height: 60,
            child: FilterTabs(
              filters: _groceryFilters,
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

        // Featured Stores - Horizontal Scroll (same width as Popular)
        if (_filteredGroceryStores.isNotEmpty)
          SliverToBoxAdapter(
            child: _buildSectionHeader('Featured Stores', screenWidth),
          ),
        if (_filteredGroceryStores.isNotEmpty)
          SliverToBoxAdapter(
            child: SizedBox(
              height: screenHeight * 0.28,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                itemCount: _filteredGroceryStores.length > 6 ? 6 : _filteredGroceryStores.length,
                itemBuilder: (context, index) {
                  return _buildGrocerySliderCard(
                    _filteredGroceryStores[index],
                    screenWidth,
                    screenHeight,
                  );
                },
              ),
            ),
          ),

        // Popular Grocery Stores - Horizontal Scroll
        if (_filteredGroceryStores.isNotEmpty)
          SliverToBoxAdapter(
            child: _buildSectionHeader('Popular Stores', screenWidth),
          ),
        if (_filteredGroceryStores.isNotEmpty)
          SliverToBoxAdapter(
            child: SizedBox(
              height: screenHeight * 0.28,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                itemCount: _filteredGroceryStores.length > 8 ? 8 : _filteredGroceryStores.length,
                itemBuilder: (context, index) {
                  return _buildGrocerySliderCard(
                    _filteredGroceryStores[index],
                    screenWidth,
                    screenHeight,
                  );
                },
              ),
            ),
          ),

        // Top Rated Stores - Grid Design
        if (_filteredGroceryStores.isNotEmpty)
          SliverToBoxAdapter(
            child: _buildSectionHeader('Top Rated Stores', screenWidth),
          ),
        if (_filteredGroceryStores.isNotEmpty)
          SliverToBoxAdapter(
            child: _buildTopRatedSection(screenWidth, screenHeight),
          ),

        // Best Deals - Compact Card Design
        if (_filteredGroceryStores.isNotEmpty)
          SliverToBoxAdapter(
            child: _buildSectionHeader('Best Deals', screenWidth),
          ),
        if (_filteredGroceryStores.isNotEmpty)
          SliverToBoxAdapter(
            child: _buildBestDealsSection(screenWidth),
          ),

        // Fast Delivery - Minimal Design
        if (_filteredGroceryStores.isNotEmpty)
          SliverToBoxAdapter(
            child: _buildSectionHeader('Fast Delivery', screenWidth),
          ),
        if (_filteredGroceryStores.isNotEmpty)
          SliverToBoxAdapter(
            child: _buildFastDeliverySection(screenWidth),
          ),

        // All Stores - List View (Limited to 6)
        if (_filteredGroceryStores.isNotEmpty)
          SliverToBoxAdapter(
            child: _buildSectionHeader('All Stores', screenWidth),
          ),
        if (_filteredGroceryStores.isNotEmpty)
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index >= 6) return const SizedBox.shrink();
                return _buildGroceryListCard(
                  _filteredGroceryStores[index],
                  screenWidth,
                );
              },
              childCount: _filteredGroceryStores.length > 6 ? 6 : _filteredGroceryStores.length,
            ),
          ),

        // Footer
        const SliverToBoxAdapter(
          child: AppFooter(),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, double screenWidth) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Text(
        title,
        style: TextStyle(
          fontSize: screenWidth * 0.048,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildTopRatedSection(double screenWidth, double screenHeight) {
    final topRated = List<Map<String, dynamic>>.from(_filteredGroceryStores)
      ..sort((a, b) => (b['rating'] as double).compareTo(a['rating'] as double));
    final top6 = topRated.take(6).toList();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: top6.length,
        itemBuilder: (context, index) {
          return _buildGridCard(top6[index], screenWidth);
        },
      ),
    );
  }

  Widget _buildBestDealsSection(double screenWidth) {
    final deals = _filteredGroceryStores.take(4).toList();
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        children: deals.map((store) => _buildCompactCard(store, screenWidth)).toList(),
      ),
    );
  }

  Widget _buildFastDeliverySection(double screenWidth) {
    final fastDelivery = List<Map<String, dynamic>>.from(_filteredGroceryStores)
      ..sort((a, b) {
        final timeA = int.parse((a['deliveryTime'] as String).replaceAll(' min', ''));
        final timeB = int.parse((b['deliveryTime'] as String).replaceAll(' min', ''));
        return timeA.compareTo(timeB);
      });
    final top4 = fastDelivery.take(4).toList();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: top4.take(2).map((store) => _buildMinimalCard(store, screenWidth)).toList(),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              children: top4.skip(2).take(2).map((store) => _buildMinimalCard(store, screenWidth)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrocerySliderCard(
    Map<String, dynamic> store,
    double screenWidth,
    double screenHeight,
  ) {
    final cardWidth = screenWidth * 0.42;
    final sliderHeight = screenHeight * 0.28;
    final imageHeight = sliderHeight * 0.55;
    final category = store['category'] as String;
    final categoryColor = _getCategoryColor(category);
    final categoryIcon = _getCategoryIcon(category);

    return Container(
      width: cardWidth,
      height: sliderHeight,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with Category Badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
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
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: cardWidth,
                      height: imageHeight,
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.store, size: 40, color: Colors.grey),
                    );
                  },
                ),
              ),
              // Category Badge
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: categoryColor.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(categoryIcon, size: 12, color: Colors.white),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          category.split(' ').first,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Rating Badge
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.95),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, color: Colors.amber.shade700, size: 12),
                      const SizedBox(width: 2),
                      Text(
                        store['rating'].toString(),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Store Name
                  Text(
                    store['name'] as String,
                    style: TextStyle(
                      fontSize: screenWidth * 0.038,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  // Delivery Info
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 12, color: Colors.grey.shade600),
                      const SizedBox(width: 4),
                      Text(
                        store['deliveryTime'] as String,
                        style: TextStyle(
                          fontSize: screenWidth * 0.030,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.local_shipping, size: 12, color: Colors.grey.shade600),
                      const SizedBox(width: 4),
                      Text(
                        '₹${store['deliveryFee']}',
                        style: TextStyle(
                          fontSize: screenWidth * 0.030,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Category Tag
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: categoryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: categoryColor.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(categoryIcon, size: 10, color: categoryColor),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            category,
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                              color: categoryColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
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
    final imageSize = screenWidth * 0.22;
    final category = store['category'] as String;
    final categoryColor = _getCategoryColor(category);
    final categoryIcon = _getCategoryIcon(category);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.12),
            blurRadius: 8,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          // Image with Category Badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
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
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                          strokeWidth: 2,
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
              // Category Badge
              Positioned(
                bottom: 4,
                right: 4,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: categoryColor,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(categoryIcon, size: 10, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        store['name'] as String,
                        style: TextStyle(
                          fontSize: screenWidth * 0.042,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0A3D91).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
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
                  ],
                ),
                const SizedBox(height: 6),
                // Category Tag
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: categoryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: categoryColor.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(categoryIcon, size: 12, color: categoryColor),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          category,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: categoryColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 14, color: Colors.grey.shade600),
                    const SizedBox(width: 4),
                    Text(
                      store['deliveryTime'] as String,
                      style: TextStyle(
                        fontSize: screenWidth * 0.032,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(Icons.local_shipping, size: 14, color: Colors.grey.shade600),
                    const SizedBox(width: 4),
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

  Widget _buildGridCard(Map<String, dynamic> store, double screenWidth) {
    final category = store['category'] as String;
    final categoryColor = _getCategoryColor(category);
    final categoryIcon = _getCategoryIcon(category);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.12),
            blurRadius: 10,
            offset: const Offset(0, 3),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  child: Image.network(
                    store['imageUrl'] as String,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.store, size: 40, color: Colors.grey),
                      );
                    },
                  ),
                ),
                // Top Rating Badge
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade700,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, size: 12, color: Colors.white),
                        const SizedBox(width: 2),
                        Text(
                          store['rating'].toString(),
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Category Badge
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: categoryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(categoryIcon, size: 14, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          // Details
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    store['name'] as String,
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.access_time, size: 10, color: Colors.grey.shade600),
                          const SizedBox(width: 2),
                          Text(
                            store['deliveryTime'] as String,
                            style: TextStyle(
                              fontSize: screenWidth * 0.028,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '₹${store['deliveryFee']}',
                        style: TextStyle(
                          fontSize: screenWidth * 0.030,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0A3D91),
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

  Widget _buildCompactCard(Map<String, dynamic> store, double screenWidth) {
    final category = store['category'] as String;
    final categoryColor = _getCategoryColor(category);
    final categoryIcon = _getCategoryIcon(category);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            categoryColor.withValues(alpha: 0.05),
            Colors.white,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: categoryColor.withValues(alpha: 0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: categoryColor.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              store['imageUrl'] as String,
              width: screenWidth * 0.18,
              height: screenWidth * 0.18,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: screenWidth * 0.18,
                  height: screenWidth * 0.18,
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
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        store['name'] as String,
                        style: TextStyle(
                          fontSize: screenWidth * 0.040,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: categoryColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star, size: 10, color: Colors.white),
                          const SizedBox(width: 2),
                          Text(
                            store['rating'].toString(),
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(categoryIcon, size: 12, color: categoryColor),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        category,
                        style: TextStyle(
                          fontSize: screenWidth * 0.030,
                          color: categoryColor,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 12, color: Colors.grey.shade600),
                    const SizedBox(width: 4),
                    Text(
                      store['deliveryTime'] as String,
                      style: TextStyle(
                        fontSize: screenWidth * 0.030,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(Icons.local_shipping, size: 12, color: Colors.grey.shade600),
                    const SizedBox(width: 4),
                    Text(
                      '₹${store['deliveryFee']}',
                      style: TextStyle(
                        fontSize: screenWidth * 0.030,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w600,
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

  Widget _buildMinimalCard(Map<String, dynamic> store, double screenWidth) {
    final category = store['category'] as String;
    final categoryColor = _getCategoryColor(category);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.08),
            blurRadius: 6,
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
              width: double.infinity,
              height: screenWidth * 0.25,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: double.infinity,
                  height: screenWidth * 0.25,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.store, size: 30, color: Colors.grey),
                );
              },
            ),
          ),
          // Details
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  store['name'] as String,
                  style: TextStyle(
                    fontSize: screenWidth * 0.036,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.access_time, size: 10, color: Colors.green.shade700),
                              const SizedBox(width: 2),
                              Text(
                                store['deliveryTime'] as String,
                                style: TextStyle(
                                  fontSize: screenWidth * 0.026,
                                  color: Colors.green.shade700,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '₹${store['deliveryFee']}',
                      style: TextStyle(
                        fontSize: screenWidth * 0.032,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0A3D91),
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
