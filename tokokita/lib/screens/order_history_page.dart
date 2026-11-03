import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/order_database.dart';
import 'main_page.dart'; 

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  List _orders = [];
  bool _isLoading = true;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Ambil seluruh riwayat pesanan (getAllOrders)
  Future<void> _fetchOrders({String keyword = ''}) async {
    setState(() => _isLoading = true);
    final data = await OrderDatabase.instance.searchOrders(keyword);
    if (!mounted) return;
    setState(() {
      _orders = data;
      _isLoading = false;
    });
  }

  // Ubah status pesanan (updateOrderStatus)
  Future<void> _changeStatus(int id, String currentStatus) async {
    final nextStatus = currentStatus == 'Diproses' ? 'Selesai' : 'Diproses';
    await OrderDatabase.instance.updateOrderStatus(id, nextStatus);

    _fetchOrders(keyword: _searchController.text);

    Get.snackbar(
      'Status Diperbarui',
      'Status pesanan #$id diubah menjadi $nextStatus',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blueAccent,
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
      borderRadius: 8,
    );
  }

  // Hapus riwayat pesanan (deleteOrder) & refresh tampilan
  Future<void> _removeOrder(int id) async {
    await OrderDatabase.instance.deleteOrder(id);

    _fetchOrders(keyword: _searchController.text);

    Get.snackbar(
      'Pesanan Dihapus',
      'Riwayat pesanan #$id telah dihapus.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
      borderRadius: 8,
    );
  }
  // Helper fungsi navigasi kembali secara dinamis
  void _handleBackNavigation(BuildContext context) {
    if (Navigator.canPop(context)) {
      Get.back(); 
    } else {
      Get.offAll(() => const MainPage()); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _handleBackNavigation(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Riwayat Pesanan'),
          // Navigasi tombol back yang dinamis
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => _handleBackNavigation(context),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Cari berdasarkan status ',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            _fetchOrders();
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                ),
                onChanged: (value) {
                  _fetchOrders(keyword: value);
                },
              ),
            ),

            // Daftar Pesanan
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _orders.isEmpty
                      ? const Center(
                          child: Text('Pesanan tidak ditemukan'),
                        )
                      : ListView.builder(
                          itemCount: _orders.length,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          itemBuilder: (context, index) {
                            final order = _orders[index];
                            final isSelesai = order['status'] == 'Selesai';

                            return Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: ListTile(
                                title: Text(
                                  'Order #${order['id']} • ${order['tanggal']}',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 4),
                                    Text('Item: ${order['daftarItem']}'),
                                    Text(
                                      'Total: Rp ${order['totalHarga'].toStringAsFixed(0)}',
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Status: ${order['status']}',
                                      style: TextStyle(
                                        color: isSelesai ? Colors.green : Colors.orange,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.sync, color: Colors.blue),
                                      tooltip: 'Ubah Status',
                                      onPressed: () => _changeStatus(
                                        order['id'],
                                        order['status'],
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.red),
                                      tooltip: 'Hapus Pesanan',
                                      onPressed: () => _removeOrder(order['id']),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}