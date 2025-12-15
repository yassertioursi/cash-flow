import 'package:cashflow/core/theme/app_colors.dart';
import 'package:cashflow/core/theme/glass_surface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/add_transaction_modal.dart';
import '../widgets/home_widgets.dart';
import '../widgets/skeletons/home_page_skeleton.dart';
import '../../domain/entities/eco_data.dart';
import '../../domain/entities/weekly_transaction_data.dart';
import '../../domain/usecases/calculate_weekly_transactions.dart';
import '../../../wallet/domain/entities/transaction.dart';
import '../../../wallet/presentation/bloc/wallet_bloc.dart';
import '../../../user/presentation/bloc/user_bloc.dart';
import '../../../settings/presentation/bloc/settings_bloc.dart';
import '../../../../core/enums/enums.dart';
import '../../../../core/presentation/controllers/navigation_cubit.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../injection_container.dart' as di;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static final _calculateWeeklyTransactions = CalculateWeeklyTransactions();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return BlocProvider(
      create: (_) => di.sl<WalletBloc>()..add(LoadWalletDataEvent()),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: BlocListener<WalletBloc, BaseWalletState>(
          listener: (context, state) {
            final settingsBloc = context.read<SettingsBloc>();
            final settingsState = settingsBloc.state;
            if (settingsState is! SettingsLoadedState) {
              return;
            }

            if (state is TransactionAddedSuccess) {
              if (settingsState.preferences.budgetPreferences.dailyBudgetLimit != null) {
                _checkHighConsumptionAlert(context, state.dailyExpense, EPeriodType.daily);
              }
              if (settingsState.preferences.budgetPreferences.weeklyBudgetLimit != null) {
                _checkHighConsumptionAlert(context, state.weeklyExpense, EPeriodType.weekly);
              }
              if (settingsState.preferences.budgetPreferences.monthlyExpenseLimit != null) {
                _checkHighConsumptionAlert(context, state.monthlyExpense, EPeriodType.monthly);
              }
            }
          },
          child: BlocBuilder<WalletBloc, BaseWalletState>(
            builder: (context, state) {
              if (state is WalletLoading) {
                return const HomePageSkeleton();
              }

              if (state is WalletError) {
                return Center(
                  child: Text(
                    state.message,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                );
              }

              if (state is WalletLoaded) {
                return _HomeBody(
                  loc: loc,
                  theme: theme,
                  state: state,
                  ecoData: EcoData.fromTransactions(state.transactions),
                  weeklyData: _calculateWeeklyTransactions(state.recentTransactions),
                  onAddTransaction: (type, {Transaction? transaction}) =>
                      _showAddTransactionModal(context, type, transactionToEdit: transaction),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  void _showAddTransactionModal(
    BuildContext context,
    ETransactionType type, {
    Transaction? transactionToEdit,
  }) {
    final walletBloc = context.read<WalletBloc>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => BlocProvider.value(
        value: walletBloc,
        child: AddTransactionModal(
          transactionType: type,
          transactionToEdit: transactionToEdit,
        ),
      ),
    );
  }

  _checkHighConsumptionAlert(BuildContext context, double amount, EPeriodType period) {
    final loc = AppLocalizations.of(context)!;
    final settingsBloc = context.read<SettingsBloc>();
    final settingsState = settingsBloc.state;
    if (settingsState is! SettingsLoadedState) {
      return;
    }

    double highExpenseThreshold = 0.0;
    switch (period) {
      case EPeriodType.daily:
        highExpenseThreshold = settingsState.preferences.budgetPreferences.dailyBudgetLimit ?? 0.0;
      case EPeriodType.weekly:
        highExpenseThreshold = settingsState.preferences.budgetPreferences.weeklyBudgetLimit ?? 0.0;
      case EPeriodType.monthly:
        highExpenseThreshold = settingsState.preferences.budgetPreferences.monthlyExpenseLimit ?? 0.0;
      case EPeriodType.yearly:
      case EPeriodType.allTime:
        highExpenseThreshold = double.infinity;
    }
    if (amount > highExpenseThreshold) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(loc.ntfAlertConsumptionTitle),
          content: Text(loc.ntfAlertConsumptionBody(amount.toStringAsPrecision(2))),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(loc.btnCancel),
            ),
          ],
        ),
      );
    }
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody({
    required this.loc,
    required this.theme,
    required this.state,
    required this.ecoData,
    required this.weeklyData,
    required this.onAddTransaction,
  });

  final AppLocalizations loc;
  final ThemeData theme;
  final WalletLoaded state;
  final EcoData ecoData;
  final WeeklyTransactionData weeklyData;
  final void Function(ETransactionType type, {Transaction? transaction}) onAddTransaction;

  @override
  Widget build(BuildContext context) {
    final userState = context.watch<UserBloc>().state;
    final userName =
        userState is UserLoadedState ? userState.user.fullName : '';

    return Column(
      children: [
        _HeaderSection(
          loc: loc,
          theme: theme,
          greeting: userName.isNotEmpty ? loc.helloUser(userName) : loc.welcome,
          totalBalance: state.totalBalance,
          monthlySavings: state.monthlySavings,
          weeklyData: weeklyData,
          onIncomePressed: () => onAddTransaction(ETransactionType.income),
          onExpensePressed: () => onAddTransaction(ETransactionType.expense),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                EcoFootprintCard(ecoData: ecoData),
                const SizedBox(height: 8),
                _TransactionsSection(
                  loc: loc,
                  theme: theme,
                  transactions: state.transactions,
                  onTransactionTap: (transaction) => onAddTransaction(
                    transaction.type,
                    transaction: transaction,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection({
    required this.loc,
    required this.theme,
    required this.greeting,
    required this.totalBalance,
    required this.monthlySavings,
    required this.weeklyData,
    required this.onIncomePressed,
    required this.onExpensePressed,
  });

  final AppLocalizations loc;
  final ThemeData theme;
  final String greeting;
  final double totalBalance;
  final double monthlySavings;
  final WeeklyTransactionData weeklyData;
  final VoidCallback onIncomePressed;
  final VoidCallback onExpensePressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: theme.brightness == Brightness.dark
                  ? AppColors.darkSurfaceLifted
                  : const Color(0xFFEDF1F7),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(28.0),
                bottomRight: Radius.circular(28.0),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HomeHeader(
                welcomeText: greeting,
                titleText: loc.appTitle,
              ),
              const SizedBox(height: 16),
              BalanceCard(
                totalBalance: totalBalance,
                monthlySavings: monthlySavings,
                weeklyData: weeklyData,
              ),
              const SizedBox(height: 12),
              HomeActionButtons(
                incomeLabel: loc.lbIncome,
                expenseLabel: loc.lbExpense,
                onIncomePressed: onIncomePressed,
                onExpensePressed: onExpensePressed,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TransactionsSection extends StatelessWidget {
  const _TransactionsSection({
    required this.loc,
    required this.theme,
    required this.transactions,
    required this.onTransactionTap,
  });

  final AppLocalizations loc;
  final ThemeData theme;
  final List<Transaction> transactions;
  final void Function(Transaction) onTransactionTap;

  static const int _maxVisibleTransactions = 5;

  @override
  Widget build(BuildContext context) {
    final hideValue = context.select((SettingsBloc bloc) {
      final state = bloc.state;
      if (state is SettingsLoadedState) {
        return state.preferences.appearancePreferences.hideValues;
      }
      return false;
    });

    return Column(
      children: [
        _buildHeader(context),
        const SizedBox(height: 8),
        _buildList(hideValue),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            loc.dashboardRecentTransactions,
            style: theme.textTheme.titleMedium,
          ),
          TextButton(
            onPressed: () {
              context.read<NavigationCubit>().goToWallet();
            },
            child: Text(loc.btnViewAll),
          ),
        ],
      ),
    );
  }

  Widget _buildList(bool hideValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GlassSurface(
        frosted: true,
        radius: 22,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        child: transactions.isEmpty
            ? _buildEmptyState()
            : _buildTransactionsList(hideValue),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Text(
          textAlign: TextAlign.center,
          loc.dashboardNoTransactions,
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.outlineVariant,
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionsList(bool hideValue) {
    final visibleCount = transactions.length > _maxVisibleTransactions
        ? _maxVisibleTransactions
        : transactions.length;

    return Column(
      children: [
        for (var i = 0; i < visibleCount; i++)
          DismissibleTransactionCard(
            transaction: transactions[i],
            onTap: () => onTransactionTap(transactions[i]),
            hideValue: hideValue,
          ),
      ],
    );
  }
}
