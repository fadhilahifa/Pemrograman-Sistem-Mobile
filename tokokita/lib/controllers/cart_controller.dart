import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product.dart';
import '../screens/order_history_page.dart';
import '../services/order_database.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;

  int get totalItem => cartItems.length;

  double get totalPrice {
    return cartItems.fold(
        0.0, (sum, item) => sum + (item.product.price * item.quantity));
  }

  void addToCart(Product product, {int quantity = 1}) {
    var existingItem = cartItems.indexWhere((item) => item.product == product);
    if (existingItem >= 0) {
      cartItems[existingItem].quantity += quantity;
      cartItems.refresh();
    } else {
      cartItems.add(CartItem(product: product, quantity: quantity));
    }

    Get.snackbar(
      'Berhasil',
      '$quantity ${product.name} ditambahkan ke keranjang',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
    );
  }

  void incrementQuantity(CartItem cartItem) {
    cartItem.quantity++;
    cartItems.refresh();
  }

  void decrementQuantity(CartItem cartItem) {
    if (cartItem.quantity > 1) {
      cartItem.quantity--;
      cartItems.refresh();
    } else {
      removeFromCart(cartItem.product);
    }
  }

  void removeFromCart(Product product) {
    cartItems.removeWhere((item) => item.product == product);
    Get.snackbar(
      'Dihapus',
      '${product.name} dihapus dari keranjang',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
    );
  }

  void clearCart() {
    cartItems.clear();
    Get.snackbar(
      'Keranjang Kosong',
      'Tidak ada produk dalam keranjang belanja',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orangeAccent,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
    );
  }

  void confirmClearCart() {
    Get.defaultDialog(
      title: 'Kosongkan Keranjang',
      titleStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Color.fromARGB(255, 244, 114, 114),
      ),
      middleText:
          'Apakah Anda yakin ingin menghapus seluruh item di keranjang belanja?',
      middleTextStyle: const TextStyle(fontSize: 14, color: Colors.black87),
      backgroundColor: Colors.white,
      radius: 12,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      textCancel: 'Batal',
      cancelTextColor: Colors.grey[700],
      onCancel: () {},
      textConfirm: 'Ya, Kosongkan',
      confirmTextColor: Colors.white,
      buttonColor: const Color.fromARGB(255, 244, 114, 114),
      onConfirm: () {
        Get.back();
        clearCart();
      },
    );
  }

  // POIN 1: Menyimpan pesanan ke SQLite dan membuka Halaman Riwayat Pesanan
  Future<void> checkout() async {
    if (cartItems.isEmpty) {
      Get.snackbar(
        'Gagal Checkout',
        'Keranjang belanja Anda masih kosong.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      );
      return;
    }

    final now = DateTime.now();
    final formattedDate =
        "${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";

    final daftarItemStr = cartItems
        .map((item) => "${item.product.name} (x${item.quantity})")
        .join(', ');

    final total = totalPrice;

    // Simpan ke database SQLite
    await OrderDatabase.instance.insertOrder({
      'tanggal': formattedDate,
      'daftarItem': daftarItemStr,
      'totalHarga': total,
      'status': 'Diproses',
    });

    // Kosongkan keranjang belanja
    cartItems.clear();

    Get.snackbar(
      'Checkout Berhasil',
      'Pesanan berhasil disimpan ke Riwayat Pesanan!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
    );

    // Menggantikan CheckoutPage dengan OrderHistoryPage
    Get.off(() => const OrderHistoryPage());
  }
}