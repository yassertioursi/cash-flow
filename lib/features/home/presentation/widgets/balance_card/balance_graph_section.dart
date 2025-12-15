import 'package:flutter/material.dart';

import '../../../../../core/constants/ui_data.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../domain/entities/weekly_transaction_data.dart';
import 'weekly_bar_chart.dart';
import 'package:cashflow/core/theme/app_icons.dart';

class BalanceGraphSection extends StatelessWidget {
  const BalanceGraphSection({
    super.key,
    required this.weeklyData,
    required this.onBackPressed,
  });

  final WeeklyTransactionData weeklyData;
  final VoidCallback onBackPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;

    return Container(
      height: kBalanceCardHeight,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, theme, loc),
          const SizedBox(height: 4),
          Expanded(
            child: WeeklyBarChart(weeklyData: weeklyData),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ThemeData theme, AppLocalizations loc) {
    return Row(
      children: [
        IconButton(
          onPressed: onBackPressed,
          icon: Icon(
            AppIcons.chevronLeft,
            size: kBalanceCardIconSize,
            color: const Color(0xFF0A0D14),
          ),
        ),
        Text(
          loc.dashboardWeeklyOverview,
          style: theme.textTheme.titleMedium?.copyWith(
            color: const Color(0xFF0A0D14),
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () => _showInfoDialog(context, loc),
          icon: Icon(
            AppIcons.info,
            size: 24,
            color: const Color(0xFF0A0D14),
          ),
        ),
      ],
    );
  }

  void _showInfoDialog(BuildContext context, AppLocalizations loc) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 0.0),
        actionsPadding: const EdgeInsets.all(8.0),
        content: Text(loc.dashboardWeeklyOverviewInfo),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(MaterialLocalizations.of(context).okButtonLabel),
          ),
        ],
      ),
    );
  }
}

