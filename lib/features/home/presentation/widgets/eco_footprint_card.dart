import 'package:cashflow/features/home/domain/entities/eco_data.dart';
import 'package:cashflow/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import 'package:cashflow/core/theme/app_icons.dart';

class EcoFootprintCard extends StatelessWidget {
  const EcoFootprintCard({super.key, required this.ecoData});

  static const double kMaxCarbonFootprint = 4800.0;

  final EcoData ecoData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;
    final isDark = theme.brightness == Brightness.dark;

    final surface = isDark ? AppColors.darkSurfaceLifted : Colors.white;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final textColor = isDark ? AppColors.darkForeground : Color(0xFF141A26);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surface,
        border: Border.all(color: border, width: 1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            loc.lbMonthlyProgress,
            style: theme.textTheme.titleSmall?.copyWith(
              color: textColor,
            ),
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: CircularProgressIndicator(
                          value: 1 - (ecoData.carbonFootprint / kMaxCarbonFootprint).clamp(0, 1),
                          strokeWidth: 6,
                          valueColor: AlwaysStoppedAnimation(_getDangerColor(ecoData.carbonFootprint, isDark)),
                          backgroundColor: textColor.withValues(alpha: 0.2),
                        ),
                      ),
                      Column(
                        children: [
                          Icon(AppIcons.leaf, color: _getDangerColor(ecoData.carbonFootprint, isDark), size: 40),
                          Text(
                            '${(100 - (ecoData.carbonFootprint / kMaxCarbonFootprint * 100)).clamp(0, 100).toStringAsFixed(0)}%',
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      loc.lbEcoFootprint,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: textColor,
                      ),
                    ),
                    Text(
                      loc.ecoFootprintValue(ecoData.carbonFootprint.toStringAsFixed(1)),
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      loc.lbEcoFootprintCompensation,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: textColor,
                      ),
                    ),
                    Text(
                      loc.ecoFootprintCompensation(ecoData.treesPlanted),
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: textColor,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getDangerColor(double value, bool isDark) {
    final goodColor = isDark ? AppColors.incomeGreen : Colors.green.shade600;
    if (value < kMaxCarbonFootprint / 3) {
      return goodColor;
    } else if (value < 2 * kMaxCarbonFootprint / 3) {
      return isDark ? Colors.orange.shade300 : Colors.orange;
    } else {
      return isDark ? Colors.red.shade300 : Colors.red;
    }
  }
}

