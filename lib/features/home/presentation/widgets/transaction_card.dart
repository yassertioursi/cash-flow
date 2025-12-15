import 'package:cashflow/features/settings/domain/entities/settings_entities.dart';
import 'package:flutter/material.dart';

import '../../../wallet/domain/entities/transaction.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/enums/enums.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_formatters.dart';
import '../../../../core/constants/category_data.dart';
import '../../../../core/presentation/widgets/sensitive_text.dart';
import 'package:cashflow/core/theme/app_icons.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    super.key,
    required this.appearancePreferences,
    required this.transaction,
    required this.onTap,
    this.blackAndWhite = false,
    this.hideValue = false,
  });

  final AppearancePreferences appearancePreferences;
  final Transaction transaction;
  final VoidCallback onTap;
  final bool blackAndWhite;
  final bool hideValue;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    double value = transaction.amountAsDouble;

    final accentColor = blackAndWhite
        ? theme.colorScheme.outlineVariant
        : AppColors.getColorFromTransactionType(transaction.type);

    return ListTile(
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: accentColor.withValues(alpha: 0.14),
        foregroundColor: accentColor,
        child: Icon(transaction.type == ETransactionType.income
            ? AppIcons.trendingUp
            : CategoryRepository.getIcon(transaction.category)),
      ),
      title: Text(transaction.name),
      subtitle: Text(CategoryRepository.getLabel(transaction.category, loc),
          style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (hideValue)
            SensitiveText(
              text: AppFormatters.formatCurrencyWithPreference(
                  value, appearancePreferences.currencyFormat, loc.localeName),
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: accentColor, fontWeight: FontWeight.w600),
            )
          else
            Text(
                AppFormatters.formatCurrencyWithPreference(value, appearancePreferences.currencyFormat, loc.localeName),
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: accentColor, fontWeight: FontWeight.w600)),
          Text(
            AppFormatters.formatDateShort(transaction.date, loc.localeName),
            style: theme.textTheme.bodySmall,
          )
        ],
      ),
    );
  }
}

