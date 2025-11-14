import 'package:flutter/material.dart';
import 'order_history_page.dart';

class CartPage extends StatefulWidget {
  final Map<String, dynamic>? restaurant;
  final Map<String, int>? cartItems;
  final List<Map<String, dynamic>>? menuItems;

  const CartPage({
    super.key,
    this.restaurant,
    this.cartItems,
    this.menuItems,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Map<String, int> _cartItems;
  late List<Map<String, dynamic>> _menuItems;
  String? _referralCode;
  bool _applyReferral = false;
  bool _applyCashback = false;
  String _paymentMethod = 'COD';
  String _deliveryAddress = '123 Main Street, Mumbai';

  @override
  void initState() {
    super.initState();
    _cartItems = widget.cartItems ?? {};
    _menuItems = widget.menuItems ?? [];
    _calculateCashback();
  }

  void _calculateCashback() {
    final total = _getSubtotal();
    setState(() {
      _applyCashback = total >= 200;
    });
  }

  int _getItemPrice(String itemId) {
    final item = _menuItems.firstWhere((i) => i['id'] == itemId, orElse: () => {'price': 0});
    return item['price'] as int;
  }

  int _getSubtotal() {
    int subtotal = 0;
    _cartItems.forEach((itemId, quantity) {
      subtotal += _getItemPrice(itemId) * quantity;
    });
    return subtotal;
  }

  int _getDeliveryFee() {
    return widget.restaurant?['deliveryFee'] ?? 0;
  }

  int _getReferralDiscount() {
    if (_applyReferral && _getSubtotal() >= 150) {
      return 50; // ₹50 discount
    }
    return 0;
  }

  int _getCashback() {
    if (_applyCashback && _getSubtotal() >= 200) {
      return 20; // ₹20 Manna Coin
    }
    return 0;
  }

  int _getTotal() {
    return _getSubtotal() + _getDeliveryFee() - _getReferralDiscount();
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
      _calculateCashback();
    });
  }

  void _placeOrder() {
    final total = _getTotal();
    if (total < 100) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Minimum order amount is ₹100'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Show order confirmation
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Order Placed!'),
        content: Text('Your order of ₹$total has been placed successfully.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close cart
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const OrderHistoryPage()),
              );
            },
            child: const Text('View Orders'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final subtotal = _getSubtotal();
    final deliveryFee = _getDeliveryFee();
    final referralDiscount = _getReferralDiscount();
    final cashback = _getCashback();
    final total = _getTotal();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: _cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  Text(
                    'Your cart is empty',
                    style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Restaurant Info
                  if (widget.restaurant != null)
                    Container(
                      padding: const EdgeInsets.all(16),
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
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              widget.restaurant!['imageUrl'] as String? ?? 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400&h=300&fit=crop',
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 60,
                                  height: 60,
                                  color: Colors.grey.shade200,
                                  child: const Icon(Icons.restaurant, size: 30, color: Colors.grey),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.restaurant!['name'] as String,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  widget.restaurant!['deliveryTime'] as String,
                                  style: TextStyle(color: Colors.grey.shade600),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 16),

                  // Cart Items
                  const Text(
                    'Items',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ..._cartItems.entries.map((entry) {
                    final itemId = entry.key;
                    final quantity = entry.value;
                    final item = _menuItems.firstWhere((i) => i['id'] == itemId);
                    final price = item['price'] as int;
                    final imageUrl = item['imageUrl'] as String? ?? 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=400&h=300&fit=crop';

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
                          // Item Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              imageUrl,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 80,
                                  height: 80,
                                  color: Colors.grey.shade200,
                                  child: const Icon(Icons.fastfood, size: 30, color: Colors.grey),
                                );
                              },
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  width: 80,
                                  height: 80,
                                  color: Colors.grey.shade100,
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
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
                                  '₹$price',
                                  style: TextStyle(
                                    color: Colors.green.shade700,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline),
                                onPressed: () => _updateQuantity(itemId, -1),
                              ),
                              Text(
                                quantity.toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline),
                                onPressed: () => _updateQuantity(itemId, 1),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),

                  const SizedBox(height: 24),

                  // Referral Code
                  if (subtotal >= 150)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blue.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.card_giftcard, color: Colors.blue.shade700),
                              const SizedBox(width: 8),
                              const Text(
                                'Referral Code',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Enter referral code',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              suffixIcon: IconButton(
                                icon: const Text('Apply'),
                                onPressed: () {
                                  if (_referralCode != null && _referralCode!.isNotEmpty) {
                                    setState(() {
                                      _applyReferral = true;
                                    });
                                  }
                                },
                              ),
                            ),
                            onChanged: (value) => _referralCode = value,
                          ),
                          if (_applyReferral)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                '₹50 discount applied!',
                                style: TextStyle(
                                  color: Colors.green.shade700,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 16),

                  // Cashback
                  if (_applyCashback)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.amber.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.monetization_on, color: Colors.amber.shade700),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Welcome Cashback: ₹$cashback Manna Coin',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.amber.shade900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 24),

                  // Payment Method
                  const Text(
                    'Payment Method',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text('Cash on Delivery'),
                          value: 'COD',
                          groupValue: _paymentMethod,
                          onChanged: (value) => setState(() => _paymentMethod = value!),
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text('Online'),
                          value: 'Online',
                          groupValue: _paymentMethod,
                          onChanged: (value) => setState(() => _paymentMethod = value!),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Address
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Delivery Address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.location_on),
                    ),
                    controller: TextEditingController(text: _deliveryAddress),
                    onChanged: (value) => _deliveryAddress = value,
                  ),

                  const SizedBox(height: 16),

                  // Notes
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Delivery Notes (Optional)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.note),
                    ),
                    maxLines: 2,
                  ),

                  const SizedBox(height: 24),

                  // Price Summary
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        _buildPriceRow('Subtotal', subtotal),
                        _buildPriceRow('Delivery Fee', deliveryFee),
                        if (referralDiscount > 0)
                          _buildPriceRow('Referral Discount', -referralDiscount, isDiscount: true),
                        const Divider(),
                        _buildPriceRow('Total', total, isTotal: true),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Place Order Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _placeOrder,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Place Order',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }

  Widget _buildPriceRow(String label, int amount, {bool isDiscount = false, bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            '₹$amount',
            style: TextStyle(
              fontSize: isTotal ? 20 : 16,
              fontWeight: FontWeight.bold,
              color: isDiscount ? Colors.green.shade700 : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

