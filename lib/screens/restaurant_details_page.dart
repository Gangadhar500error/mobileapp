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

  final List<Map<String, dynamic>> _menuItems = [
    {
      'id': '1',
      'name': 'Margherita Pizza',
      'price': 299,
      'description': 'Classic cheese pizza with fresh mozzarella',
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
      'id': '3',
      'name': 'Veg Burger',
      'price': 149,
      'description': 'Fresh vegetables with special sauce',
      'imageUrl': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400&h=300&fit=crop',
      'category': 'Burgers'
    },
    {
      'id': '4',
      'name': 'French Fries',
      'price': 99,
      'description': 'Crispy golden fries with seasoning',
      'imageUrl': 'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=400&h=300&fit=crop',
      'category': 'Sides'
    },
    {
      'id': '5',
      'name': 'Coca Cola',
      'price': 49,
      'description': 'Cold refreshing carbonated drink',
      'imageUrl': 'https://images.unsplash.com/photo-1554866585-cd94860890b7?w=400&h=300&fit=crop',
      'category': 'Beverages'
    },
    {
      'id': '6',
      'name': 'Chicken Wings',
      'price': 249,
      'description': 'Spicy chicken wings with dip',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
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
        ],
      ),
    );
  }
}
