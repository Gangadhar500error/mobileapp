import 'package:flutter/material.dart';
import 'cart_page.dart';
import '../components/bottom_cart_view.dart';

class RestaurantDetailsPage extends StatefulWidget {
  final Map<String, dynamic> restaurant;
  final Function(int)? onCartUpdate;

  const RestaurantDetailsPage({
    super.key,
    required this.restaurant,
    this.onCartUpdate,
  });

  @override
  State<RestaurantDetailsPage> createState() => _RestaurantDetailsPageState();
}

class _RestaurantDetailsPageState extends State<RestaurantDetailsPage> {
  final Map<String, int> _cartItems = {}; // itemId -> quantity
  bool _isMenuOpen = false;
  String? _selectedCategory;
  final ScrollController _menuScrollController = ScrollController();

  final List<Map<String, dynamic>> _menuItems = [
    // Pizza
    {
      'id': '1',
      'name': 'Margherita Pizza',
      'price': 299,
      'description': 'Classic cheese pizza with fresh mozzarella and basil',
      'imageUrl': 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=400&h=300&fit=crop',
      'category': 'Pizza'
    },
    {
      'id': '2',
      'name': 'Pepperoni Pizza',
      'price': 349,
      'description': 'Spicy pepperoni with cheese and herbs',
      'imageUrl': 'https://images.unsplash.com/photo-1628840042765-356cda07504e?w=400&h=300&fit=crop',
      'category': 'Pizza'
    },
    {
      'id': '7',
      'name': 'Veg Supreme Pizza',
      'price': 379,
      'description': 'Loaded with fresh vegetables and cheese',
      'imageUrl': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=400&h=300&fit=crop',
      'category': 'Pizza'
    },
    {
      'id': '8',
      'name': 'Farmhouse Pizza',
      'price': 399,
      'description': 'Capsicum, onions, mushrooms and cheese',
      'imageUrl': 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=400&h=300&fit=crop',
      'category': 'Pizza'
    },
    // Burgers
    {
      'id': '3',
      'name': 'Veg Burger',
      'price': 149,
      'description': 'Fresh vegetables with special sauce',
      'imageUrl': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400&h=300&fit=crop',
      'category': 'Burgers'
    },
    {
      'id': '9',
      'name': 'Chicken Burger',
      'price': 199,
      'description': 'Grilled chicken patty with fresh veggies',
      'imageUrl': 'https://images.unsplash.com/photo-1551782450-17144efb9c50?w=400&h=300&fit=crop',
      'category': 'Burgers'
    },
    {
      'id': '10',
      'name': 'Cheese Burger',
      'price': 179,
      'description': 'Double cheese with special sauce',
      'imageUrl': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400&h=300&fit=crop',
      'category': 'Burgers'
    },
    // Sides
    {
      'id': '4',
      'name': 'French Fries',
      'price': 99,
      'description': 'Crispy golden fries with seasoning',
      'imageUrl': 'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=400&h=300&fit=crop',
      'category': 'Sides'
    },
    {
      'id': '11',
      'name': 'Onion Rings',
      'price': 129,
      'description': 'Crispy fried onion rings',
      'imageUrl': 'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=400&h=300&fit=crop',
      'category': 'Sides'
    },
    {
      'id': '12',
      'name': 'Garlic Bread',
      'price': 119,
      'description': 'Toasted bread with garlic butter',
      'imageUrl': 'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=400&h=300&fit=crop',
      'category': 'Sides'
    },
    // Beverages
    {
      'id': '5',
      'name': 'Coca Cola',
      'price': 49,
      'description': 'Cold refreshing carbonated drink',
      'imageUrl': 'https://images.unsplash.com/photo-1554866585-cd94860890b7?w=400&h=300&fit=crop',
      'category': 'Beverages'
    },
    {
      'id': '13',
      'name': 'Pepsi',
      'price': 49,
      'description': 'Refreshing cola drink',
      'imageUrl': 'https://images.unsplash.com/photo-1554866585-cd94860890b7?w=400&h=300&fit=crop',
      'category': 'Beverages'
    },
    {
      'id': '14',
      'name': 'Fresh Lime Soda',
      'price': 69,
      'description': 'Fresh lime with soda water',
      'imageUrl': 'https://images.unsplash.com/photo-1554866585-cd94860890b7?w=400&h=300&fit=crop',
      'category': 'Beverages'
    },
    {
      'id': '15',
      'name': 'Mango Shake',
      'price': 99,
      'description': 'Fresh mango milkshake',
      'imageUrl': 'https://images.unsplash.com/photo-1554866585-cd94860890b7?w=400&h=300&fit=crop',
      'category': 'Beverages'
    },
    // Appetizers
    {
      'id': '6',
      'name': 'Chicken Wings',
      'price': 249,
      'description': 'Spicy chicken wings with dip',
      'imageUrl': 'https://images.unsplash.com/photo-1527477396000-e27163b481c2?w=400&h=300&fit=crop',
      'category': 'Appetizers'
    },
    {
      'id': '16',
      'name': 'Chicken Nuggets',
      'price': 199,
      'description': 'Crispy chicken nuggets with sauce',
      'imageUrl': 'https://images.unsplash.com/photo-1527477396000-e27163b481c2?w=400&h=300&fit=crop',
      'category': 'Appetizers'
    },
    {
      'id': '17',
      'name': 'Spring Rolls',
      'price': 149,
      'description': 'Crispy vegetable spring rolls',
      'imageUrl': 'https://images.unsplash.com/photo-1527477396000-e27163b481c2?w=400&h=300&fit=crop',
      'category': 'Appetizers'
    },
  ];

  void _addToCart(String itemId, Map<String, dynamic> item) {
    setState(() {
      _cartItems[itemId] = (_cartItems[itemId] ?? 0) + 1;
    });
    
    if (widget.onCartUpdate != null) {
      widget.onCartUpdate!(_totalCartItems);
    }
  }

  void _updateQuantity(String itemId, int change) {
    setState(() {
      final currentQty = _cartItems[itemId] ?? 0;
      final newQty = (currentQty + change).clamp(0, 99);
      if (newQty == 0) {
        _cartItems.remove(itemId);
      } else {
        _cartItems[itemId] = newQty;
      }
    });
    
    if (widget.onCartUpdate != null) {
      widget.onCartUpdate!(_totalCartItems);
    }
  }


  int get _totalCartItems => _cartItems.values.fold(0, (sum, qty) => sum + qty);
  
  int get _totalAmount {
    int total = 0;
    _cartItems.forEach((itemId, quantity) {
      final item = _menuItems.firstWhere((i) => i['id'] == itemId, orElse: () => {'price': 0});
      total += (item['price'] as int) * quantity;
    });
    return total;
  }

  void _showMenuSheet() {
    setState(() {
      _isMenuOpen = true;
      _selectedCategory = null;
    });
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) => _buildMenuSheet(setSheetState),
      ),
    ).whenComplete(() {
      if (mounted) {
        setState(() {
          _isMenuOpen = false;
          _selectedCategory = null;
        });
      }
    });
  }

  void _scrollToCategory(String category) {
    // Find the first item with this category and scroll to it
    final index = _menuItems.indexWhere((item) => item['category'] == category);
    if (index != -1 && _menuScrollController.hasClients) {
      // Calculate approximate position (each item is roughly 120px)
      final position = index * 120.0;
      _menuScrollController.animateTo(
        position,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget _buildMenuSheet(StateSetter setSheetState) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    // Group items by category and count them
    final Map<String, int> categoryCounts = {};
    for (var item in _menuItems) {
      final category = item['category'] as String;
      categoryCounts[category] = (categoryCounts[category] ?? 0) + 1;
    }
    
    final categories = categoryCounts.keys.toList()..sort();
    
    // Get items for selected category
    final categoryItems = _selectedCategory != null
        ? _menuItems.where((item) => item['category'] == _selectedCategory).toList()
        : <Map<String, dynamic>>[];
    
    return SafeArea(
      top: false,
      bottom: false,
      child: Align(
        alignment: Alignment.bottomRight,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          width: screenWidth * 0.75,
          height: _selectedCategory != null ? screenHeight * 0.7 : screenHeight * 0.5,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  if (_selectedCategory != null)
                    IconButton(
                      icon: const Icon(Icons.arrow_back, size: 20),
                      onPressed: () {
                        setState(() {
                          _selectedCategory = null;
                        });
                        setSheetState(() {});
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  Expanded(
                    child: Text(
                      _selectedCategory ?? 'Menu',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  // Menu Icon
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0A3D91).withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.restaurant_menu,
                      size: 18,
                      color: Color(0xFF0A3D91),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // Content
            Expanded(
              child: _selectedCategory == null
                  ? ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        final count = categoryCounts[category]!;
                        
                        return InkWell(
                          onTap: () {
                            setState(() {
                              _selectedCategory = category;
                            });
                            setSheetState(() {});
                            // Scroll to category items in main page
                            _scrollToCategory(category);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    category,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                Text(
                                  '$count',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Icon(
                                  Icons.chevron_right,
                                  size: 18,
                                  color: Colors.grey.shade400,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      itemCount: categoryItems.length,
                      itemBuilder: (context, index) {
                        final item = categoryItems[index];
                        final itemId = item['id'] as String;
                        final quantity = _cartItems[itemId] ?? 0;
                        
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildMenuItemCardForSheet(item, itemId, quantity, setSheetState),
                        );
                      },
                    ),
            ),
          ],
        ),
        ),
      ),
    );
  }

  Widget _buildMenuItemCardForSheet(
    Map<String, dynamic> item,
    String itemId,
    int quantity,
    StateSetter setSheetState,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
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
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Item Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              item['imageUrl'] as String,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.fastfood, size: 40, color: Colors.grey),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          // Item Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'] as String,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item['description'] as String,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹${item['price']}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0A3D91),
                      ),
                    ),
                    // Add/Quantity Controls
                    if (quantity > 0)
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF0A3D91),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove, color: Colors.white, size: 18),
                              onPressed: () {
                                setState(() {
                                  _updateQuantity(itemId, -1);
                                });
                                setSheetState(() {});
                              },
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                minWidth: 32,
                                minHeight: 32,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                quantity.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add, color: Colors.white, size: 18),
                              onPressed: () {
                                setState(() {
                                  _updateQuantity(itemId, 1);
                                });
                                setSheetState(() {});
                              },
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                minWidth: 32,
                                minHeight: 32,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Material(
                        color: const Color(0xFF0A3D91),
                        borderRadius: BorderRadius.circular(20),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _addToCart(itemId, item);
                            });
                            setSheetState(() {});
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                            child: const Text(
                              'ADD',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
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

  Widget _buildMenuItemCard(Map<String, dynamic> item, String itemId, int quantity) {
    return Container(
      padding: const EdgeInsets.all(12),
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
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Item Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              item['imageUrl'] as String,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.fastfood, size: 40, color: Colors.grey),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          // Item Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'] as String,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item['description'] as String,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹${item['price']}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0A3D91),
                      ),
                    ),
                    // Add/Quantity Controls
                    if (quantity > 0)
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF0A3D91),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove, color: Colors.white, size: 18),
                              onPressed: () => _updateQuantity(itemId, -1),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                minWidth: 32,
                                minHeight: 32,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                quantity.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add, color: Colors.white, size: 18),
                              onPressed: () => _updateQuantity(itemId, 1),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                minWidth: 32,
                                minHeight: 32,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Material(
                        color: const Color(0xFF0A3D91),
                        borderRadius: BorderRadius.circular(20),
                        child: InkWell(
                          onTap: () => _addToCart(itemId, item),
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                            child: const Text(
                              'ADD',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
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

  @override
  void dispose() {
    _menuScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _menuScrollController,
        slivers: [
          // App Bar with Restaurant Image
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                widget.restaurant['imageUrl'] as String? ?? 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400&h=300&fit=crop',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade300,
                    child: const Center(
                      child: Icon(Icons.restaurant, size: 80, color: Colors.grey),
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ),
          ),
          
          // Restaurant Info
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.restaurant['name'] as String,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        '${widget.restaurant['rating']}',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.access_time, color: Colors.grey.shade600, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        widget.restaurant['deliveryTime'] as String,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        '₹${widget.restaurant['deliveryFee']} delivery',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                  const Divider(height: 32),
                  
                  // Menu Items
                  const Text(
                    'Menu',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          
          // Menu Items List
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = _menuItems[index];
                final itemId = item['id'] as String;
                final quantity = _cartItems[itemId] ?? 0;
                
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Item Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          item['imageUrl'] as String,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 100,
                              height: 100,
                              color: Colors.grey.shade200,
                              child: const Icon(Icons.fastfood, size: 40, color: Colors.grey),
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              width: 100,
                              height: 100,
                              color: Colors.grey.shade100,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Item Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'] as String,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['description'] as String,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '₹${item['price']}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF0A3D91),
                                  ),
                                ),
                                // Quantity Controls
                                if (quantity > 0)
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove_circle_outline),
                                        onPressed: () => _updateQuantity(itemId, -1),
                                        color: const Color(0xFF0A3D91),
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        child: Text(
                                          quantity.toString(),
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.add_circle_outline),
                                        onPressed: () => _updateQuantity(itemId, 1),
                                        color: const Color(0xFF0A3D91),
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                      ),
                                    ],
                                  )
                                else
                                  Material(
                                    color: const Color(0xFF0A3D91),
                                    borderRadius: BorderRadius.circular(8),
                                    child: InkWell(
                                      onTap: () => _addToCart(itemId, item),
                                      borderRadius: BorderRadius.circular(8),
                                      child: Container(
                                        width: 28,
                                        height: 28,
                                        alignment: Alignment.center,
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                      ),
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
              },
              childCount: _menuItems.length,
            ),
          ),
          // Bottom padding for cart view
          SliverToBoxAdapter(
            child: SizedBox(height: _totalCartItems > 0 ? 100 : 0),
          ),
        ],
      ),
          // Bottom Cart View
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomCartView(
              itemCount: _totalCartItems,
              totalAmount: _totalAmount,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartPage(
                      restaurant: widget.restaurant,
                      cartItems: _cartItems,
                      menuItems: _menuItems,
                    ),
                  ),
                );
              },
            ),
          ),
          // Sticky Menu Button (Bottom Right) with Animation
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            bottom: _isMenuOpen 
                ? (_totalCartItems > 0 ? 280 : 220)
                : (_totalCartItems > 0 ? 80 : 20),
            right: 20,
            child: FloatingActionButton(
              onPressed: _showMenuSheet,
              backgroundColor: const Color(0xFF0A3D91),
              child: AnimatedRotation(
                duration: const Duration(milliseconds: 300),
                turns: _isMenuOpen ? 0.125 : 0,
                child: const Icon(Icons.restaurant_menu, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
