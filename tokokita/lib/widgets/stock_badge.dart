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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: _getBadgeColor().withOpacity(0.15),
        border: Border.all(color: _getBadgeColor()),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 12,
          color: _getBadgeColor(),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}