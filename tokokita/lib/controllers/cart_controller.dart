import 'package:get/get.dart';
import '../models/product.dart'; 
import 'package:flutter/material.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartController extends GetxController {
  
  var cartItems = <CartItem>[].obs;

  int get totalItem => cartItems.length;

  double get totalPrice {
    return cartItems.fold(0.0, (sum, item) => sum + (item.product.price * item.quantity));
  }

  void addToCart(Product product, {int quantity = 1}) {
    var existingItem = cartItems.indexWhere((item) => item.product == product);
    if (existingItem >= 0) {
      cartItems[existingItem].quantity += quantity;
      cartItems.refresh(); // Memastikan UI diperbarui saat quantity berubah
    } else {
      cartItems.add(CartItem(product: product, quantity: quantity));
    }
    
    // Snackbar dipanggil sekali saja di sini secara rapi
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
  // Method untuk menambah kuantitas produk dalam keranjang
  void incrementQuantity(CartItem cartItem) {
    cartItem.quantity++;
    cartItems.refresh();
  }

  // Method untuk mengurangi kuantitas produk dalam keranjang
  void decrementQuantity(CartItem cartItem) {
    if (cartItem.quantity > 1) {
      cartItem.quantity--;
      cartItems.refresh();
    } else {
      removeFromCart(cartItem.product);
    }
  }

  // Method untuk menghapus produk dari keranjang
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
      middleText: 'Apakah Anda yakin ingin menghapus seluruh item di keranjang belanja?',
      middleTextStyle: const TextStyle(fontSize: 14, color: Colors.black87),
      backgroundColor: Colors.white,
      radius: 12,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      
      // Matikan tombol default bawaan, kita buat kustomisasi via actions agar lebih terkontrol
      textCancel: 'Batal',
      cancelTextColor: Colors.grey[700],
      onCancel: () {
        // Dialog otomatis tertutup
      },

      textConfirm: 'Ya, Kosongkan',
      confirmTextColor: Colors.white,
      buttonColor: Color.fromARGB(255, 244, 114, 114),
      onConfirm: () {
        // 1. Tutup dialog terlebih dahulu secara eksplisit
        Get.back(); 
        
        // 2. Baru kosongkan keranjang dan jalankan snackbar
        clearCart();
      },
    );
  }
}