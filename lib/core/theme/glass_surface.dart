import 'package:flutter/material.dart';

import 'app_colors.dart';

class GlassSurface extends StatelessWidget {
  const GlassSurface({
    super.key,
    required this.child,
    this.padding,
    this.margin = EdgeInsets.zero,
    this.radius = 18,
    this.tint,
    this.borderColor,
    this.borderWidth = 1,
    this.frosted = false,
    this.blurSigma = 18,
    this.elevated = false,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry margin;
  final double radius;
  final Color? tint;
  final Color? borderColor;
  final double borderWidth;

  final bool frosted;

  final double blurSigma;

  final bool elevated;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final effectiveTint =
        tint ??
        (elevated
            ? (isDark ? AppColors.darkMuted : Color(0xFFEEF1F7))
            : (isDark ? AppColors.darkSurfaceLifted : Colors.white));
    final effectiveBorder =
        borderColor ??
        (isDark ? AppColors.darkBorder : AppColors.lightBorder);

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: effectiveTint,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: effectiveBorder, width: borderWidth),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.25)
                : Colors.black.withValues(alpha: 0.05),
            blurRadius: elevated ? 18 : 8,
            offset: Offset(0, elevated ? 8 : 2),
          ),
        ],
      ),
      child: padding == null ? child : Padding(padding: padding!, child: child),
    );
  }
}