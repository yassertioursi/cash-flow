import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/router/app_router.dart';
import 'core/services/auto_backup_service.dart';
import 'core/services/notification_service.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/settings/domain/enums/color_blind_mode.dart';
import 'features/settings/domain/enums/font_size_preference.dart';
import 'features/settings/presentation/bloc/settings_bloc.dart';
import 'features/user/presentation/bloc/user_bloc.dart';
import 'features/wallet/presentation/bloc/wallet_bloc.dart';
import 'injection_container.dart' as di;
import 'core/theme/app_theme.dart';
import 'core/theme/cashflow_backdrop.dart';
import '/l10n/app_localizations.dart';
import 'package:cashflow/core/theme/app_icons.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {

    WidgetsBinding.instance.ensureSemantics();
  }

  try {
    await di.init();
    await di.sl<NotificationService>().init();

    di.sl<AuthBloc>().add(AppStartedEvent());
    runApp(const CashflowApp());
  } catch (e) {

    debugPrint('Failed to initialize app: $e');
    runApp(const ErrorApp());
  }
}

class CashflowApp extends StatelessWidget {
  const CashflowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>.value(value: di.sl<AuthBloc>()),
        BlocProvider<UserBloc>.value(value: di.sl<UserBloc>()),
        BlocProvider<SettingsBloc>.value(value: di.sl<SettingsBloc>()),
        BlocProvider<WalletBloc>(create: (_) => di.sl<WalletBloc>()),
      ],
      child: const _AuthUserSyncWrapper(),
    );
  }
}

class _AuthUserSyncWrapper extends StatefulWidget {
  const _AuthUserSyncWrapper();

  @override
  State<_AuthUserSyncWrapper> createState() => _AuthUserSyncWrapperState();
}

class _AuthUserSyncWrapperState extends State<_AuthUserSyncWrapper> {
  bool _backupChecked = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _syncUserFromAuthState(context.read<AuthBloc>().state);
    });
  }

  void _syncUserFromAuthState(BaseAuthState state) {
    if (state is AuthAuthenticatedState) {
      context.read<UserBloc>().add(LoadUserEvent(id: state.userId));
      context.read<SettingsBloc>().add(LoadSettingsEvent());

      if (!_backupChecked) {
        _scheduleBackupCheck(context, state.userId);
      }
    }
  }

  Future<void> _scheduleBackupCheck(BuildContext context, String userId) async {
    _backupChecked = true;

    final settingsBloc = context.read<SettingsBloc>();
    await settingsBloc.stream
        .firstWhere((state) => state is SettingsLoadedState);

    final settingsState = settingsBloc.state;
    if (settingsState is! SettingsLoadedState) return;

    final walletBloc = di.sl<WalletBloc>()..add(LoadWalletDataEvent());
    await walletBloc.stream.firstWhere((state) => state is WalletLoaded);

    final walletState = walletBloc.state;
    if (walletState is! WalletLoaded) return;

    final autoBackupService = di.sl<AutoBackupService>();
    final backupPath = await autoBackupService.checkAndPerformBackupIfDue(
      userId: userId,
      transactions: walletState.transactions,
      dataPreferences: settingsState.preferences.dataPreferences,
    );

    if (backupPath != null) {
      debugPrint('[App] Automatic backup created: $backupPath');

      if (!context.mounted) return;
      final loc = AppLocalizations.of(context)!;

      final notificationService = di.sl<NotificationService>();
      await notificationService.showBackupCompleteNotification(
        title: loc.ntfBackupCompleteTitle,
        body: loc.ntfBackupCompleteBody,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, BaseAuthState>(
      listener: (context, state) => _syncUserFromAuthState(state),
      child: BlocBuilder<SettingsBloc, BaseSettingsState>(
        buildWhen: (previous, current) =>
            _conditionsToRebuild(previous, current),
        builder: (context, settingsState) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(
              _getTextScaleFactor(settingsState),
            ),
          ),
          child: ColorFiltered(
            colorFilter: AppTheme.getColorFilter(
              settingsState is SettingsLoadedState
                  ? settingsState
                      .preferences.appearancePreferences.colorBlindMode
                  : ColorBlindMode.none,
            ),
            child: MaterialApp.router(
               debugShowCheckedModeBanner: false,
              title: 'Cashflow',
              theme: AppTheme.lightTheme,
darkTheme: AppTheme.darkTheme,
    builder: (context, child) =>
        SafeArea(child: CashflowBackdrop(child: child ?? const SizedBox.shrink())),
    themeMode: settingsState is SettingsLoadedState
        ? settingsState
            .preferences.appearancePreferences.flutterThemeMode
        : ThemeMode.dark,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en'),
                Locale('fr'),
              ],
              routerConfig: di.sl<AppRouter>().router,
            ),
          ),
        ),
      ),
    );
  }

  double _getTextScaleFactor(BaseSettingsState state) {
    if (state is SettingsLoadedState) {
      return AppTheme.getTextScaleFactor(
          state.preferences.appearancePreferences.fontSize);
    }
    return AppTheme.getTextScaleFactor(FontSizePreference.medium);
  }

  bool _conditionsToRebuild(
      BaseSettingsState previous, BaseSettingsState current) {
    if (previous != current) return true;

    if (previous is SettingsLoadedState && current is SettingsLoadedState) {
      if (previous.preferences != current.preferences) {
        return true;
      }
    }

    return false;
  }
}

class ErrorApp extends StatelessWidget {
  const ErrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cashflow - Error',
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(AppIcons.error, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                const Text(
                  'Failed to initialize app',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Please restart the app. If the problem persists, contact support.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

