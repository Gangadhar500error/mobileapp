import 'package:flutter/material.dart';
import '../components/banner_slider.dart';
import '../components/location_picker.dart';
import '../components/app_footer.dart';
import '../components/header.dart';
import 'restaurant_details_page.dart';
import 'profile_page.dart';
import 'best_offers_page.dart';
import 'all_restaurants_page.dart';
import 'grocery_page.dart';
import 'add_address_page.dart';
import 'categories_page.dart';
import 'cart_page.dart';
import 'wishlist_page.dart';

class HomePage extends StatefulWidget {
  final String? initialCity;
  
  const HomePage({super.key, this.initialCity});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late String _selectedCity;
  String _selectedFilter = 'All';
  bool _isFoodActive = true; // Default: Food tab active
  final List<String> _filters = ['All', 'Biriyani', 'Tiffin', 'Lunch', 'Dinner', 'Pizza', 'Fast Food', 'Chinese', 'Italian'];
  int _cartItemCount = 0;
  final int _wishlistCount = 5; // Static wishlist count
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> _restaurants = [
    // Biriyani
    {
      'id': '1',
      'name': 'Hyderabadi Biriyani House',
      'cuisine': 'Biriyani',
      'type': 'food', // food or snacks
      'rating': 4.8,
      'deliveryTime': '30 min',
      'deliveryFee': 35,
      'imageUrl': 'https://images.unsplash.com/photo-1589302168068-964664d93dc0?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': '2',
      'name': 'Shah Ghouse Biriyani',
      'cuisine': 'Biriyani',
      'type': 'food',
      'rating': 4.7,
      'deliveryTime': '25 min',
      'deliveryFee': 30,
      'imageUrl': 'https://images.unsplash.com/photo-1631452180519-c014fe946bc7?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': '3',
      'name': 'Paradise Biriyani',
      'cuisine': 'Biriyani',
      'type': 'food',
      'rating': 4.6,
      'deliveryTime': '28 min',
      'deliveryFee': 40,
      'imageUrl': 'https://images.unsplash.com/photo-1633945274309-2c16f9692d30?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    // Tiffin
    {
      'id': '4',
      'name': 'South Indian Tiffin',
      'cuisine': 'Tiffin',
      'type': 'food',
      'rating': 4.5,
      'deliveryTime': '20 min',
      'deliveryFee': 25,
      'imageUrl': 'https://images.unsplash.com/photo-1631452180519-c014fe946bc7?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': '5',
      'name': 'Idli Express',
      'cuisine': 'Tiffin',
      'type': 'food',
      'rating': 4.4,
      'deliveryTime': '18 min',
      'deliveryFee': 20,
      'imageUrl': 'https://images.unsplash.com/photo-1589302168068-964664d93dc0?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': '6',
      'name': 'Dosa Corner',
      'cuisine': 'Tiffin',
      'type': 'food',
      'rating': 4.6,
      'deliveryTime': '22 min',
      'deliveryFee': 22,
      'imageUrl': 'https://images.unsplash.com/photo-1617196034796-73dfa7e1f3e3?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    // Lunch
    {
      'id': '7',
      'name': 'Lunch Box Special',
      'cuisine': 'Lunch',
      'type': 'food',
      'rating': 4.5,
      'deliveryTime': '25 min',
      'deliveryFee': 30,
      'imageUrl': 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': '8',
      'name': 'Thali Express',
      'cuisine': 'Lunch',
      'type': 'food',
      'rating': 4.4,
      'deliveryTime': '20 min',
      'deliveryFee': 28,
      'imageUrl': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': '9',
      'name': 'Home Style Lunch',
      'cuisine': 'Lunch',
      'type': 'food',
      'rating': 4.6,
      'deliveryTime': '30 min',
      'deliveryFee': 35,
      'imageUrl': 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    // Dinner
    {
      'id': '10',
      'name': 'Dinner Delight',
      'cuisine': 'Dinner',
      'type': 'food',
      'rating': 4.7,
      'deliveryTime': '35 min',
      'deliveryFee': 40,
      'imageUrl': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': '11',
      'name': 'Royal Dinner',
      'cuisine': 'Dinner',
      'type': 'food',
      'rating': 4.5,
      'deliveryTime': '30 min',
      'deliveryFee': 45,
      'imageUrl': 'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': '12',
      'name': 'Family Dinner',
      'cuisine': 'Dinner',
      'type': 'food',
      'rating': 4.6,
      'deliveryTime': '32 min',
      'deliveryFee': 38,
      'imageUrl': 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    // Pizza
    {
      'id': '13',
      'name': 'Pizza Palace',
      'cuisine': 'Pizza',
      'type': 'food',
      'rating': 4.5,
      'deliveryTime': '25 min',
      'deliveryFee': 29,
      'imageUrl': 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': '14',
      'name': 'Dominos Pizza',
      'cuisine': 'Pizza',
      'type': 'food',
      'rating': 4.5,
      'deliveryTime': '25 min',
      'deliveryFee': 30,
      'imageUrl': 'https://images.unsplash.com/photo-1628840042765-356cda07504e?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': '15',
      'name': 'Pizza Hut',
      'cuisine': 'Pizza',
      'type': 'food',
      'rating': 4.4,
      'deliveryTime': '28 min',
      'deliveryFee': 32,
      'imageUrl': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    // Grocery
    {
      'id': '16',
      'name': 'Fresh Mart',
      'cuisine': 'Grocery',
      'type': 'grocery',
      'rating': 4.5,
      'deliveryTime': '20 min',
      'deliveryFee': 25,
      'imageUrl': 'https://images.unsplash.com/photo-1556910103-1c02745aae4d?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': '17',
      'name': 'Super Market',
      'cuisine': 'Grocery',
      'type': 'grocery',
      'rating': 4.4,
      'deliveryTime': '25 min',
      'deliveryFee': 30,
      'imageUrl': 'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': '18',
      'name': 'Quick Grocery',
      'cuisine': 'Grocery',
      'type': 'grocery',
      'rating': 4.3,
      'deliveryTime': '15 min',
      'deliveryFee': 20,
      'imageUrl': 'https://images.unsplash.com/photo-1586511925558-a4c8d0bc6b81?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': '28',
      'name': 'Daily Needs Store',
      'cuisine': 'Grocery',
      'type': 'grocery',
      'rating': 4.6,
      'deliveryTime': '18 min',
      'deliveryFee': 22,
      'imageUrl': 'https://images.unsplash.com/photo-1604719312566-8912a92235c6?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': '29',
      'name': 'Organic Grocery',
      'cuisine': 'Grocery',
      'type': 'grocery',
      'rating': 4.7,
      'deliveryTime': '22 min',
      'deliveryFee': 28,
      'imageUrl': 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': '30',
      'name': 'City Mart',
      'cuisine': 'Grocery',
      'type': 'grocery',
      'rating': 4.5,
      'deliveryTime': '20 min',
      'deliveryFee': 25,
      'imageUrl': 'https://images.unsplash.com/photo-1604719312566-8912a92235c6?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    // Fast Food
    {
      'id': '19',
      'name': 'Burger King',
      'cuisine': 'Fast Food',
      'type': 'food',
      'rating': 4.3,
      'deliveryTime': '20 min',
      'deliveryFee': 19,
      'imageUrl': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': '20',
      'name': 'McDonald\'s',
      'cuisine': 'Fast Food',
      'type': 'food',
      'rating': 4.4,
      'deliveryTime': '15 min',
      'deliveryFee': 20,
      'imageUrl': 'https://images.unsplash.com/photo-1551782450-17144efb9c50?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': '21',
      'name': 'KFC',
      'cuisine': 'Fast Food',
      'type': 'food',
      'rating': 4.3,
      'deliveryTime': '20 min',
      'deliveryFee': 25,
      'imageUrl': 'https://images.unsplash.com/photo-1527477396000-e27163b481c2?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    // Chinese
    {
      'id': '22',
      'name': 'Chinese Express',
      'cuisine': 'Chinese',
      'type': 'food',
      'rating': 4.2,
      'deliveryTime': '18 min',
      'deliveryFee': 30,
      'imageUrl': 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': '23',
      'name': 'Panda Express',
      'cuisine': 'Chinese',
      'type': 'food',
      'rating': 4.1,
      'deliveryTime': '22 min',
      'deliveryFee': 28,
      'imageUrl': 'https://images.unsplash.com/photo-1544025162-d76694265947?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': '24',
      'name': 'Wok Express',
      'cuisine': 'Chinese',
      'type': 'food',
      'rating': 4.3,
      'deliveryTime': '20 min',
      'deliveryFee': 32,
      'imageUrl': 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    // Italian
    {
      'id': '25',
      'name': 'Pasta Corner',
      'cuisine': 'Italian',
      'type': 'food',
      'rating': 4.6,
      'deliveryTime': '22 min',
      'deliveryFee': 35,
      'imageUrl': 'https://images.unsplash.com/photo-1551183053-bf91a1d81141?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': '26',
      'name': 'Italian Bistro',
      'cuisine': 'Italian',
      'type': 'food',
      'rating': 4.5,
      'deliveryTime': '25 min',
      'deliveryFee': 38,
      'imageUrl': 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400&h=300&fit=crop',
      'isOpen': true,
    },
    {
      'id': '27',
      'name': 'Mama Mia',
      'cuisine': 'Italian',
      'type': 'food',
      'rating': 4.4,
      'deliveryTime': '28 min',
      'deliveryFee': 40,
      'imageUrl': 'https://images.unsplash.com/photo-1628840042765-356cda07504e?w=400&h=300&fit=crop',
      'isOpen': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedCity = widget.initialCity ?? 'Hyderabad';
  }

  IconData _getFilterIcon(String filter) {
    switch (filter) {
      case 'All':
        return Icons.restaurant_menu;
      case 'Biriyani':
        return Icons.rice_bowl;
      case 'Tiffin':
        return Icons.breakfast_dining;
      case 'Lunch':
        return Icons.lunch_dining;
      case 'Dinner':
        return Icons.dinner_dining;
      case 'Pizza':
        return Icons.local_pizza;
      case 'Grocery':
        return Icons.shopping_cart;
      case 'Fast Food':
        return Icons.fastfood;
      case 'Chinese':
        return Icons.set_meal;
      case 'Italian':
        return Icons.restaurant;
      default:
        return Icons.restaurant;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredRestaurants {
    // Only filter food restaurants (grocery is handled separately in GroceryPage)
    List<Map<String, dynamic>> foodRestaurants = _restaurants.where((r) {
      String type = r['type'] as String? ?? 'food'; // Default to food if type not specified
      return type == 'food';
    }).toList();
    
    // Then filter by selected cuisine category
    if (_selectedFilter == 'All') {
      return foodRestaurants;
    }
    return foodRestaurants.where((r) => r['cuisine'] == _selectedFilter).toList();
  }

  Widget _getCurrentPage() {
    switch (_selectedIndex) {
      case 0:
        // Show grocery page if grocery is active, otherwise show food content
        return _isFoodActive
            ? _buildHomeContent()
            : GroceryPage(
                selectedCity: _selectedCity,
                isFoodActive: _isFoodActive,
                onFoodTap: () {
                  setState(() {
                    _isFoodActive = true;
                    _selectedFilter = 'All';
                  });
                  _scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                },
                onGroceryTap: () {
                  setState(() {
                    _isFoodActive = false;
                    _selectedFilter = 'All';
                  });
                  _scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                },
                onCitySelected: (city) {
                  setState(() {
                    _selectedCity = city;
                  });
                },
                onWishlistTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Wishlist feature coming soon!')),
                  );
                },
              );
      case 1:
        return const CategoriesPage();
      case 2:
        return const BestOffersPage();
      case 3:
        return const CartPage();
      case 4:
        return const ProfilePage();
      default:
        return _buildHomeContent();
    }
  }

  Widget _buildHomeContent() {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        // App Bar with Toggle, Location, and Wishlist
        SliverAppBar(
          pinned: true,
          floating: false,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const SizedBox.shrink(),
          leadingWidth: 0,
          flexibleSpace: CustomHeader(
            scaffoldKey: GlobalKey<ScaffoldState>(),
            location: _selectedCity,
            isFoodActive: _isFoodActive,
            onFoodTap: () {
              setState(() {
                _isFoodActive = true;
                _selectedFilter = 'All';
              });
              _scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            },
            onGroceryTap: () {
              setState(() {
                _isFoodActive = false;
                _selectedFilter = 'All';
              });
              _scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            },
            onLocationTap: () {
              LocationPicker.show(
                context: context,
                currentCity: _selectedCity,
                onCitySelected: (city) {
                  setState(() {
                    _selectedCity = city;
                  });
                },
                onAddAddress: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddAddressPage(),
                    ),
                  );
                  
                  if (result != null && result is Map<String, dynamic>) {
                    setState(() {
                      _selectedCity = result['address'] ?? _selectedCity;
                    });
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
                  hintText: 'Search restaurants, dishes...',
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
                itemCount: _filters.length,
                itemBuilder: (context, index) {
                  final filter = _filters[index];
                  final isSelected = _selectedFilter == filter;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedFilter = filter;
                      });
                      // Smooth scroll to top when filter changes
                      _scrollController.animateTo(
                        0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.green.shade700 : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected ? Colors.green.shade700 : Colors.grey.shade300,
                          width: isSelected ? 2 : 1,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: Colors.green.withValues(alpha: 0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.white.withValues(alpha: 0.2) : Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(
                              _getFilterIcon(filter),
                              size: 16,
                              color: isSelected ? Colors.white : Colors.grey.shade700,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            filter,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.grey.shade700,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
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

        // Popular Restaurants Slider
        if (_filteredRestaurants.isNotEmpty) ...[
          SliverToBoxAdapter(
            child: _buildSectionHeader('Popular Restaurants', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AllRestaurantsPage(
                    restaurants: _filteredRestaurants,
                    category: _selectedFilter,
                  ),
                ),
              );
            }),
          ),
          SliverToBoxAdapter(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final screenHeight = MediaQuery.of(context).size.height;
                final sliderHeight = screenHeight * 0.28;
                return SizedBox(
                  height: sliderHeight,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: _filteredRestaurants.length > 10 ? 10 : _filteredRestaurants.length,
                    itemBuilder: (context, index) {
                      return _buildRestaurantSliderCard(_filteredRestaurants[index]);
                    },
                  ),
                );
              },
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
        ],

        // Top Rated Slider
        if (_filteredRestaurants.where((r) => (r['rating'] as double) >= 4.5).isNotEmpty) ...[
          SliverToBoxAdapter(
            child: _buildSectionHeader('Top Rated', () {
              final topRated = _filteredRestaurants.where((r) => (r['rating'] as double) >= 4.5).toList();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AllRestaurantsPage(
                    restaurants: topRated,
                    category: 'Top Rated',
                  ),
                ),
              );
            }),
          ),
          SliverToBoxAdapter(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final screenHeight = MediaQuery.of(context).size.height;
                final sliderHeight = screenHeight * 0.28;
                return SizedBox(
                  height: sliderHeight,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: _filteredRestaurants.where((r) => (r['rating'] as double) >= 4.5).length,
                    itemBuilder: (context, index) {
                      final topRated = _filteredRestaurants.where((r) => (r['rating'] as double) >= 4.5).toList();
                      return _buildRestaurantSliderCard(topRated[index]);
                    },
                  ),
                );
              },
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
        ],

        const SliverToBoxAdapter(child: SizedBox(height: 16)),

        // Filtered Restaurants List
        if (_filteredRestaurants.isNotEmpty) ...[
          SliverToBoxAdapter(
            child: _buildSectionHeader('All Restaurants', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AllRestaurantsPage(
                    restaurants: _filteredRestaurants,
                    category: _selectedFilter,
                  ),
                ),
              );
            }),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final restaurant = _filteredRestaurants[index];
                return _buildRestaurantListCard(restaurant);
              },
              childCount: _filteredRestaurants.length > 5 ? 5 : _filteredRestaurants.length,
            ),
          ),
          // Footer
          const SliverToBoxAdapter(
            child: AppFooter(),
          ),
        ] else ...[
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(40),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.restaurant, size: 60, color: Colors.grey.shade400),
                    const SizedBox(height: 16),
                    Text(
                      'No restaurants found',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Try selecting a different category',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Footer
          const SliverToBoxAdapter(
            child: AppFooter(),
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: _getCurrentPage(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.green.shade700,
        unselectedItemColor: Colors.grey.shade600,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Category'),
          BottomNavigationBarItem(icon: Icon(Icons.local_offer), label: 'Offers'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onSeeAll) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.05,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          TextButton(
            onPressed: onSeeAll,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'See All',
              style: TextStyle(
                color: Colors.green.shade700,
                fontWeight: FontWeight.w600,
                fontSize: MediaQuery.of(context).size.width * 0.035,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRestaurantSliderCard(Map<String, dynamic> restaurant) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final cardWidth = screenWidth * 0.65;
    final sliderHeight = screenHeight * 0.28;
    final imageHeight = sliderHeight * 0.6; // 60% of slider height for image
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RestaurantDetailsPage(
              restaurant: restaurant,
              onCartUpdate: (count) {
                setState(() {
                  _cartItemCount = count;
                });
              },
            ),
          ),
        );
      },
      child: Container(
        width: cardWidth,
        height: sliderHeight,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
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
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                restaurant['imageUrl'] as String,
                width: double.infinity,
                height: imageHeight,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: imageHeight,
                    color: Colors.grey.shade200,
                    child: Icon(Icons.restaurant, size: imageHeight * 0.3, color: Colors.grey),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: imageHeight,
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
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            restaurant['name'] as String,
                            style: TextStyle(
                              fontSize: screenWidth * 0.038,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (!restaurant['isOpen'])
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.red.shade100,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Closed',
                              style: TextStyle(
                                color: Colors.red.shade700,
                                fontSize: screenWidth * 0.022,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      restaurant['cuisine'] as String,
                      style: TextStyle(
                        fontSize: screenWidth * 0.03,
                        color: Colors.grey.shade600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.star, color: Colors.green.shade700, size: screenWidth * 0.03),
                                const SizedBox(width: 2),
                                Flexible(
                                  child: Text(
                                    '${restaurant['rating']}',
                                    style: TextStyle(
                                      color: Colors.green.shade700,
                                      fontSize: screenWidth * 0.028,
                                      fontWeight: FontWeight.bold,
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
                        Icon(Icons.access_time, color: Colors.grey.shade600, size: screenWidth * 0.03),
                        const SizedBox(width: 2),
                        Flexible(
                          child: Text(
                            restaurant['deliveryTime'] as String,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: screenWidth * 0.028,
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
      ),
    );
  }

  Widget _buildRestaurantListCard(Map<String, dynamic> restaurant) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageSize = screenWidth * 0.25;
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RestaurantDetailsPage(
              restaurant: restaurant,
              onCartUpdate: (count) {
                setState(() {
                  _cartItemCount = count;
                });
              },
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenWidth * 0.025,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.08),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Restaurant Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.network(
                restaurant['imageUrl'] as String,
                width: imageSize,
                height: imageSize,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: imageSize,
                    height: imageSize,
                    color: Colors.grey.shade200,
                    child: Icon(Icons.restaurant, size: imageSize * 0.3, color: Colors.grey),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    width: imageSize,
                    height: imageSize,
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
            ),
            // Restaurant Details
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.035),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Restaurant Name and Status
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                restaurant['name'] as String,
                                style: TextStyle(
                                  fontSize: screenWidth * 0.045,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                  height: 1.2,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: screenWidth * 0.01),
                              Text(
                                restaurant['cuisine'] as String,
                                style: TextStyle(
                                  fontSize: screenWidth * 0.033,
                                  color: Colors.grey.shade600,
                                  height: 1.2,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        if (!restaurant['isOpen'])
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.02,
                              vertical: screenWidth * 0.01,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: Colors.red.shade200,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              'Closed',
                              style: TextStyle(
                                color: Colors.red.shade700,
                                fontSize: screenWidth * 0.028,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: screenWidth * 0.025),
                    // Rating, Time, and Delivery Fee
                    Row(
                      children: [
                        // Rating
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.02,
                            vertical: screenWidth * 0.008,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star, color: Colors.green.shade700, size: screenWidth * 0.035),
                              SizedBox(width: screenWidth * 0.008),
                              Text(
                                '${restaurant['rating']}',
                                style: TextStyle(
                                  color: Colors.green.shade700,
                                  fontSize: screenWidth * 0.033,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.025),
                        // Delivery Time
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.access_time, color: Colors.grey.shade600, size: screenWidth * 0.035),
                            SizedBox(width: screenWidth * 0.008),
                            Text(
                              restaurant['deliveryTime'] as String,
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: screenWidth * 0.033,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: screenWidth * 0.015),
                    // Delivery Fee
                    Row(
                      children: [
                        Icon(Icons.delivery_dining, color: Colors.grey.shade600, size: screenWidth * 0.035),
                        SizedBox(width: screenWidth * 0.008),
                        Text(
                          '₹${restaurant['deliveryFee']} delivery fee',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: screenWidth * 0.031,
                            fontWeight: FontWeight.w400,
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
      ),
    );
  }
}

// Sticky Header Delegate for Tabs
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
    return child != oldDelegate.child;
  }
}
