import 'package:flutter/material.dart';
import 'package:cashflow/core/theme/app_icons.dart';

class HomeActionButtons extends StatelessWidget {
  const HomeActionButtons({
    super.key,
    required this.incomeLabel,
    required this.expenseLabel,
    required this.onIncomePressed,
    required this.onExpensePressed,
  });

  final String incomeLabel;
  final String expenseLabel;
  final VoidCallback onIncomePressed;
  final VoidCallback onExpensePressed;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final pillBackground =
        isDark ? const Color(0xFF141A26) : Colors.white;
    final borderColor =
        isDark ? const Color(0xFF232B3A) : Colors.black.withValues(alpha: 0.08);

    return Row(
      children: [
        Expanded(
          child: _ActionButton(
            label: incomeLabel,
            icon: AppIcons.add,
            iconBackgroundColor: isDark ? const Color(0xFF38D876) : const Color(0xFF1F9D55),
            pillBackground: pillBackground,
            borderColor: borderColor,
            onPressed: onIncomePressed,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ActionButton(
            label: expenseLabel,
            icon: AppIcons.remove,
            iconBackgroundColor: isDark ? const Color(0xFFFF6B6B) : const Color(0xFFD64545),
            pillBackground: pillBackground,
            borderColor: borderColor,
            onPressed: onExpensePressed,
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.icon,
    required this.iconBackgroundColor,
    required this.pillBackground,
    required this.borderColor,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final Color iconBackgroundColor;
  final Color pillBackground;
  final Color borderColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size.zero,
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 14.0),
        backgroundColor: pillBackground,
        foregroundColor: theme.colorScheme.onSurface,
        elevation: 0,
        side: BorderSide(color: borderColor, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: iconBackgroundColor,
            child: Icon(
              icon,
              size: 20,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

