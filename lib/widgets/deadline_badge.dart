import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class DeadlineBadge extends StatelessWidget {
  final DateTime deadline;
  final bool filed;

  const DeadlineBadge({super.key, required this.deadline, this.filed = false});

  @override
  Widget build(BuildContext context) {
    if (filed) {
      return _badge('Filed', AppColors.income);
    }
    final days = deadline.difference(DateTime.now()).inDays;
    if (days < 0) return _badge('Overdue', AppColors.red);
    if (days <= 14) return _badge('$days days', AppColors.vat);
    return _badge('$days days', AppColors.income);
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
