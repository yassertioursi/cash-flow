import 'package:cashflow/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<Widget>? actions;
  final Widget? subSection;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const PageHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.actions,
    this.subSection,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final topSafe = MediaQuery.paddingOf(context).top;
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, topSafe + 24.0, 20.0, 12.0),
      decoration: BoxDecoration(
        color: backgroundColor ??
            (isDark ? AppColors.darkSurfaceLifted : Color(0xFFF4F6FA)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: foregroundColor ?? theme.colorScheme.onSurface,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle!,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: foregroundColor ??
                            theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
              if (actions != null) ...actions!,
            ],
          ),
          if (subSection != null) ...[
            const SizedBox(height: 12),
            subSection!,
          ],
        ],
      ),
    );
  }
}
