import 'package:flutter/material.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF0A3D91).withValues(alpha: 0.05),
        border: Border(
          top: BorderSide(color: const Color(0xFF0A3D91).withValues(alpha: 0.1), width: 1),
        ),
      ),
      child: Column(
        children: [
          // Manna Logo/Title
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF0A3D91),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.restaurant,
                  color: Color(0xFFDAA520),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'MANNA',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2B2B2B),
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Your trusted food & grocery delivery partner',
            style: TextStyle(
              fontSize: 14,
              color: const Color(0xFF2B2B2B).withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          // Features
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildFeatureItem(Icons.local_shipping, 'Fast Delivery'),
              _buildFeatureItem(Icons.verified_user, 'Safe & Secure'),
              _buildFeatureItem(Icons.star, 'Quality Food'),
              _buildFeatureItem(Icons.support_agent, '24/7 Support'),
            ],
          ),
          const SizedBox(height: 24),
          // Divider
          Divider(color: const Color(0xFF0A3D91).withValues(alpha: 0.2)),
          const SizedBox(height: 16),
          // Copyright
          Text(
            '© 2025 Manna. All rights reserved.',
            style: TextStyle(
              fontSize: 12,
              color: const Color(0xFF2B2B2B).withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 8),
          // Social Links
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialIcon(Icons.facebook, () {}),
              const SizedBox(width: 16),
              _buildSocialIcon(Icons.camera_alt, () {}),
              const SizedBox(width: 16),
              _buildSocialIcon(Icons.share, () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0A3D91).withValues(alpha: 0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, color: const Color(0xFF0A3D91), size: 20),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: const Color(0xFF2B2B2B).withValues(alpha: 0.7),
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0A3D91).withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: const Color(0xFF0A3D91), size: 18),
      ),
    );
  }
}
