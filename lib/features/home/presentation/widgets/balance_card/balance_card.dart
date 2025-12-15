import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/ui_data.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../settings/domain/entities/settings_entities.dart';
import '../../../../settings/presentation/bloc/settings_bloc.dart';
import '../../../domain/entities/weekly_transaction_data.dart';
import '../../../domain/enum/balance_section.dart';
import 'balance_main_section.dart';
import 'balance_graph_section.dart';

class BalanceCard extends StatefulWidget {
  const BalanceCard({
    super.key,
    required this.totalBalance,
    required this.monthlySavings,
    required this.weeklyData,
  });

  final double totalBalance;
  final double monthlySavings;
  final WeeklyTransactionData weeklyData;

  @override
  State<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {
  EBalanceSection _currentSection = EBalanceSection.main;

  void _toggleSection() {
    setState(() {
      _currentSection = _currentSection == EBalanceSection.main ? EBalanceSection.graph : EBalanceSection.main;
    });
  }

  void _goToMainSection() {
    setState(() {
      _currentSection = EBalanceSection.main;
    });
  }

  @override
  Widget build(BuildContext context) {

    final appearancePreferences = context.select((SettingsBloc bloc) {
      final state = bloc.state;
      if (state is SettingsLoadedState) {
        return state.preferences.appearancePreferences;
      }
      return const AppearancePreferences();
    });

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.heroGradientStart,
        borderRadius: BorderRadius.circular(kBalanceCardBorderRadius),
        border: Border.all(
          color: const Color(0xFF0A0D14).withValues(alpha: 0.10),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.28),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: _currentSection == EBalanceSection.main
          ? BalanceMainSection(
              appearancePreferences: appearancePreferences,
              totalBalance: widget.totalBalance,
              monthlySavings: widget.monthlySavings,
              onToggleSection: _toggleSection,
            )
          : BalanceGraphSection(
              weeklyData: widget.weeklyData,
              onBackPressed: _goToMainSection,
            ),
    );
  }
}
