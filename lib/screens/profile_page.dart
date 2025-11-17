import 'package:flutter/material.dart';
import 'welcome_onboarding_page.dart';
import 'my_orders_page.dart';
import 'profile/saved_addresses_page.dart';
import 'profile/payments_wallet_page.dart';
import 'profile/offers_rewards_page.dart';
import 'profile/favourites_page.dart';
import 'profile/notifications_page.dart';
import 'profile/support_help_page.dart';
import 'profile/refund_tracking_page.dart';
import 'profile/app_settings_page.dart';
import 'profile/privacy_legal_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: const Color(0xFF0A3D91),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            _buildProfileHeader(),
            
            // App Settings
            _buildClickableSection(
              'App Settings',
              Icons.settings,
              'Edit Profile, Language, Dark Mode, Notifications',
              Colors.grey,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AppSettingsPage()),
                );
              },
            ),
            
            // My Orders - Single clickable item
            _buildClickableSection(
              'My Orders',
              Icons.receipt_long,
              'Order History, Active Orders, Repeat Order',
              Colors.blue,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyOrdersPage()),
                );
              },
            ),
            
            // Saved Addresses
            _buildClickableSection(
              'Saved Addresses',
              Icons.location_on,
              'Manage your delivery addresses',
              Colors.orange,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SavedAddressesPage()),
                );
              },
            ),
            
            // Payments & Manna Wallet
            _buildClickableSection(
              'Payments & Manna Wallet',
              Icons.account_balance_wallet,
              'Wallet: ₹1,250 • Payment Methods',
              Colors.purple,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PaymentsWalletPage()),
                );
              },
            ),
            
            // Offers & Manna Rewards
            _buildClickableSection(
              'Offers & Manna Rewards',
              Icons.local_offer,
              '2,450 Points • Available Offers',
              Colors.pink,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OffersRewardsPage()),
                );
              },
            ),
            
            // Favourites
            _buildClickableSection(
              'Favourites',
              Icons.favorite,
              'Restaurants & Dishes',
              Colors.red,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FavouritesPage()),
                );
              },
            ),
            
            // Manna Membership
            _buildClickableSection(
              'Manna Membership',
              Icons.card_membership,
              'Premium Benefits',
              Colors.purple,
              () {},
            ),
            
            // Notifications
            _buildClickableSection(
              'Notifications',
              Icons.notifications,
              'View all notifications',
              Colors.amber,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NotificationsPage()),
                );
              },
            ),
            
            // My Reviews
            _buildClickableSection(
              'My Reviews',
              Icons.rate_review,
              '15 Reviews',
              Colors.blue,
              () {},
            ),
            
            // Support & Help
            _buildClickableSection(
              'Support & Help',
              Icons.help_outline,
              'Help Center, Chat, Call Support',
              const Color(0xFF0A3D91),
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SupportHelpPage()),
                );
              },
            ),
            
            // Refund & Issue Tracking
            _buildClickableSection(
              'Refund & Issue Tracking',
              Icons.assignment,
              'Track refunds & report issues',
              Colors.red,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RefundTrackingPage()),
                );
              },
            ),
            
            // Privacy & Legal
            _buildClickableSection(
              'Privacy & Legal',
              Icons.privacy_tip,
              'Privacy Policy, Terms & Conditions',
              Colors.blue,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PrivacyLegalPage()),
                );
              },
            ),
            
            // Logout
            _buildLogoutButton(context),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          // Profile Photo
          Stack(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF0A3D91).withValues(alpha: 0.2), width: 2),
                ),
                child: ClipOval(
                  child: Image.network(
                    'https://t3.ftcdn.net/jpg/07/59/59/12/360_F_759591215_9Rz2tsvQCyFjSc3JwWihvPjlaFXn8ktT.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade200,
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.grey.shade600,
                        ),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Colors.grey.shade100,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0A3D91),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    size: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          // Name, Phone, Email
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Madankumar K',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.phone, size: 14, color: Colors.grey.shade600),
                    const SizedBox(width: 4),
                    Text(
                      '+91 9876543210',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.email, size: 14, color: Colors.grey.shade600),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'madankumar.doe@example.com',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                        overflow: TextOverflow.ellipsis,
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

  Widget _buildClickableSection(String title, IconData icon, String subtitle, Color color, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
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
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
        onTap: onTap,
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const WelcomeOnboardingPage(),
            ),
            (route) => false,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade600,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout, size: 20),
            SizedBox(width: 8),
            Text(
              'Logout',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
