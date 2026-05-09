import 'package:flutter/material.dart';

class DeadlineBadge extends StatelessWidget {
  final DateTime deadline;
  final bool filed;

  const DeadlineBadge({super.key, required this.deadline, this.filed = false});

  @override
  Widget build(BuildContext context) {
    if (filed) {
      return _badge('Filed', Colors.green);
    }
    final days = deadline.difference(DateTime.now()).inDays;
    if (days < 0) return _badge('Overdue', Colors.red);
    if (days <= 14) return _badge('$days days', Colors.amber[700]!);
    return _badge('$days days', Colors.green);
  }

  Widget _badge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
