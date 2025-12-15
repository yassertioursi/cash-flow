import 'package:cashflow/core/theme/glass_surface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/controllers/navigation_cubit.dart';
import 'home_page.dart';
import '/l10n/app_localizations.dart';
import '../../../settings/presentation/pages/settings_page.dart';
import '../../../transactions/presentation/pages/transactions_page.dart';
import 'package:cashflow/core/theme/app_icons.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static const List<Widget> _pages = [
    HomePage(),
    TransactionWalletPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return BlocProvider<NavigationCubit>(
      create: (_) => NavigationCubit(),
      child: BlocBuilder<NavigationCubit, int>(
        builder: (context, state) => Scaffold(

            backgroundColor: Colors.transparent,
            body: IndexedStack(
              index: state,
              children: _pages,
            ),
            bottomNavigationBar:
                _buildBottomNavigation(context, loc, theme, state)),
      ),
    );
  }

  Widget _buildBottomNavigation(
      BuildContext context, AppLocalizations loc, ThemeData theme, int currentIndex) {
    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(16, 0, 16, 14),
      child: GlassSurface(
        frosted: true,
        radius: 28,
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
        child: NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: (index) {
            context.read<NavigationCubit>().goToIndex(index);
          },
          backgroundColor: Colors.transparent,
          indicatorShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          destinations: [
            NavigationDestination(
              icon: Icon(AppIcons.home, size: 24),
              selectedIcon: Icon(AppIcons.home, size: 24),
              label: loc.lbHome,
            ),
            NavigationDestination(
              icon: Icon(AppIcons.wallet, size: 24),
              selectedIcon: Icon(AppIcons.wallet, size: 24),
              label: loc.lbWallet,
            ),
            NavigationDestination(
              icon: Icon(AppIcons.settings, size: 24),
              selectedIcon: Icon(AppIcons.settings, size: 24),
              label: loc.lbSettings,
            ),
          ],
        ),
      ),
    );
  }
}

