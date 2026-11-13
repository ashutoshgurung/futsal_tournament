import 'package:flutter/material.dart';

class StatusChip extends StatelessWidget {
  final String label;
  final bool isPayment;

  const StatusChip({super.key, 
    required this.label,
    required this.isPayment,
  });

  @override
  Widget build(BuildContext context) {
    final status = label.toLowerCase();

    Color color;

    if (status == 'approved' || status == 'paid') {
      color = const Color(0xFFB6F36B);
    } else if (status == 'rejected' ||
        status == 'cancelled' ||
        status == 'unpaid') {
      color = Colors.redAccent;
    } else {
      color = Colors.orangeAccent;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label[0].toUpperCase() + label.substring(1),
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}