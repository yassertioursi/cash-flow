import 'package:flutter/material.dart';

import 'app_colors.dart';

class CashflowBackdrop extends StatelessWidget {
  const CashflowBackdrop({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ColoredBox(
      color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      child: child,
    );
  }
}