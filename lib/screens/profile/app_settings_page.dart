import 'package:flutter/material.dart';
import 'edit_profile_page.dart';

class AppSettingsPage extends StatelessWidget {
  const AppSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Settings'),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildMenuItem(
            Icons.edit,
            'Edit Profile',
            'Update your personal information',
            Colors.blue,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditProfilePage()),
              );
            },
          ),
          const SizedBox(height: 12),
          _buildMenuItem(
            Icons.language,
            'Language',
            'English',
            Colors.orange,
            () {},
          ),
          const SizedBox(height: 12),
          _buildMenuItem(
            Icons.dark_mode,
            'Dark Mode',
            'Off',
            Colors.grey,
            () {},
          ),
          const SizedBox(height: 12),
          _buildMenuItem(
            Icons.notifications_active,
            'Notifications',
            'Manage notification settings',
            Colors.purple,
            () {},
          ),
          const SizedBox(height: 12),
          _buildMenuItem(
            Icons.lock,
            'Change Password',
            'Update your password',
            Colors.red,
            () {},
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, String subtitle, Color color, VoidCallback onTap) {
    return Container(
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
          padding: const EdgeInsets.all(12),
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
            fontSize: 13,
            color: Colors.grey.shade600,
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
        onTap: onTap,
      ),
    );
  }
}

