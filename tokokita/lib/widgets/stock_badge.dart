import 'package:flutter/material.dart';

class StockBadge extends StatelessWidget {
  final String status;

  const StockBadge({
    super.key,
    required this.status,
  });

  Color _getBadgeColor() {
    if (status == 'Tersedia') {
      return Colors.green;
    } else if (status == 'Stok Terbatas') {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: _getBadgeColor(),
        border: Border.all(color: _getBadgeColor()),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 10,
          color: Colors.white,
        ),
      ),
    );
  }
}