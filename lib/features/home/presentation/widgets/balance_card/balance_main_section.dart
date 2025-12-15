import 'package:cashflow/features/settings/domain/entities/settings_entities.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/ui_data.dart';
import '../../../../../core/presentation/widgets/sensitive_text.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_formatters.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../settings/domain/enums/currency_format.dart';
import 'package:cashflow/core/theme/app_icons.dart';

class BalanceMainSection extends StatelessWidget {
  const BalanceMainSection({
    super.key,
    required this.appearancePreferences,
    required this.totalBalance,
    required this.monthlySavings,
    required this.onToggleSection,
  });

  final double totalBalance;
  final double monthlySavings;
  final VoidCallback onToggleSection;
  final AppearancePreferences appearancePreferences;

  static const Color _ink = AppColors.darkPrimaryForeground;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildBalanceSection(theme, loc, appearancePreferences.currencyFormat),
          const SizedBox(height: 14),
          _buildSavingsSection(theme, loc, appearancePreferences.currencyFormat),
        ],
      ),
    );
  }

  Widget _buildBalanceSection(ThemeData theme, AppLocalizations loc, CurrencyFormat currencyFormat) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          loc.dashboardTotalBalance,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: _ink.withValues(alpha: 0.72),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        SensitiveText(
          text: AppFormatters.formatCurrencyWithPreference(totalBalance, currencyFormat, loc.localeName),
          style: theme.textTheme.headlineMedium?.copyWith(
            color: _ink,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildSavingsSection(ThemeData theme, AppLocalizations loc, CurrencyFormat currencyFormat) {
    final savingsTextStyle = theme.textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.w600,
      color: _ink,
    );

    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: _ink.withValues(alpha: 0.12),
          child: Icon(
            AppIcons.trendingUp,
            size: kBalanceCardIconSize,
            color: _ink,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(loc.dashboardMonthlySavings, style: savingsTextStyle),
            SensitiveText(
              text: AppFormatters.formatCurrencyWithPreference(monthlySavings, currencyFormat, loc.localeName),
              style: savingsTextStyle?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          onPressed: onToggleSection,
          icon: Icon(
            AppIcons.chevronRight,
            size: kBalanceCardIconSize,
            color: _ink.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}

