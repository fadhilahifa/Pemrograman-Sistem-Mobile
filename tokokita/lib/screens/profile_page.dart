import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX Navigation
import 'login_page.dart';
import 'wishlist_page.dart';
import 'order_history_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  BoxDecoration get _cardDecoration => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('Profil Saya', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          children: [
            // 1. Header Profil
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              decoration: _cardDecoration,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.pink.shade100, width: 3),
                    ),
                    child: const CircleAvatar(
                      radius: 38,
                      backgroundColor: Colors.pinkAccent,
                      child: Icon(Icons.person, size: 46, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text('Pengguna TokoKita', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 4),
                  Text('user@tokokita.com', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 2. Section Menu Utama
            Container(
              decoration: _cardDecoration,
              child: Column(
                children: [
                  // Menu Wishlist dengan Get.to
                  _buildMenuItem(
                    icon: Icons.favorite_rounded,
                    iconColor: Colors.pinkAccent,
                    bgColor: Colors.pink.shade50,
                    title: 'Wishlist Saya',
                    subtitle: 'Lihat produk favorit tersimpan',
                    onTap: () => Get.to(() => const WishlistPage()),
                  ),
                  Divider(height: 1, thickness: 1, indent: 60, color: Colors.grey[100]),

                  // Menu Riwayat Pesanan dengan Get.to
                  _buildMenuItem(
                    icon: Icons.history_rounded,
                    iconColor: Colors.deepPurple,
                    bgColor: Colors.purple.shade50,
                    title: 'Riwayat Pesanan',
                    subtitle: 'Lihat status dan riwayat transaksi',
                    onTap: () => Get.to(() => const OrderHistoryPage()),
                  ),
                  Divider(height: 1, thickness: 1, indent: 60, color: Colors.grey[100]),

                  // Menu Ke Halaman Login dengan Get.offAll
                  _buildMenuItem(
                    icon: Icons.logout_rounded,
                    iconColor: Colors.blue,
                    bgColor: Colors.blue.shade50,
                    title: 'Ke Halaman Login',
                    subtitle: 'Masuk ke akun lain',
                    onTap: () => Get.offAll(() => const LoginPage()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method 
  Widget _buildMenuItem({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      trailing: const Icon(Icons.chevron_right_rounded, color: Colors.grey),
      onTap: onTap,
    );
  }
}