import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class OrderDatabase {
  static final OrderDatabase instance = OrderDatabase._init();
  static Database? _database;

  OrderDatabase._init();

  Future<Database?> get database async {
    if (kIsWeb) return null;
    if (_database != null) return _database!;
    _database = await _initDB('tokokita_orders.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE orders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tanggal TEXT NOT NULL,
        daftarItem TEXT NOT NULL,
        totalHarga REAL NOT NULL,
        status TEXT NOT NULL
      )
    ''');
    print('DATABASE LOG: Tabel orders berhasil dibuat!');
  }

  Future<int> insertOrder(Map<String, dynamic> row) async {
    final db = await instance.database;
    if (db == null) return -1;
    return await db.insert('orders', row);
  }
  
  Future <List> getAllOrders() async {
    final db = await instance.database;
    if (db == null) return [];
    return await db.query('orders', orderBy: 'id DESC');
  }

  Future<int> updateOrderStatus(int id, String newStatus) async {
    final db = await instance.database;
    if (db == null) return 0;
    return await db.update(
      'orders',
      {'status': newStatus},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteOrder(int id) async {
    final db = await instance.database;
    if (db == null) return 0;
    return await db.delete(
      'orders',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List> searchOrders(String query) async {
    final db = await instance.database;
    if (db == null) return [];

    if (query.trim().isEmpty) {
      return await getAllOrders();
    }

    return await db.query(
      'orders',
      where: 'status LIKE ? OR daftarItem LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
      orderBy: 'id DESC',
    );
  }

  Future<void> close() async {
    final db = await _database;
    if (db != null) {
      await db.close();
    }
  }
}