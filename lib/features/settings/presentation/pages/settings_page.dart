import 'package:cashflow/core/theme/app_colors.dart';
import 'package:cashflow/core/theme/glass_surface.dart';
import 'package:cashflow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:cashflow/features/user/presentation/bloc/user_bloc.dart';
import 'package:cashflow/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/presentation/widgets/user_avatar_circle.dart';
import '../../../../core/router/app_routes.dart';
import '../bloc/settings_bloc.dart';
import '../widgets/settings_container.dart';
import '../widgets/settings_option_item.dart';
import 'package:cashflow/core/theme/app_icons.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(

      backgroundColor: Colors.transparent,

      body: BlocBuilder<SettingsBloc, BaseSettingsState>(
        builder: (context, state) {
          if (state is SettingsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SettingsErrorState) {
            return Center(
              child: Text(
                state.message ?? loc.errorUnknown,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            );
          }

          if (state is SettingsLoadedState) {
            return _buildBody(context, loc, theme, state);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    AppLocalizations loc,
    ThemeData theme,
    SettingsLoadedState state,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeader(context, loc, theme, state),
        _buildSettingsOptions(context, loc, theme),
      ],
    );
  }

  Widget _buildHeader(
    BuildContext context,
    AppLocalizations loc,
    ThemeData theme,
    SettingsLoadedState state,
  ) {
    return SizedBox(
      height: 180,
      child: Stack(
        children: [
          Container(
            height: 120,
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
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  loc.lbSettings,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  loc.settingsSubTitle,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: GlassSurface(
                    frosted: true,
                    radius: 20,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        UserAvatarCircle(imageUrl: state.user.imageUrl),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.user.fullName,
                                style: theme.textTheme.titleMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                state.user.email,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsOptions(
    BuildContext context,
    AppLocalizations loc,
    ThemeData theme,
  ) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildAccountSection(context, loc, theme),
              const SizedBox(height: 20),
              _buildPreferencesSection(context, loc, theme),
              const SizedBox(height: 20),
              _buildSecuritySection(context, loc, theme),
              const SizedBox(height: 20),
              _buildSupportSection(context, loc, theme),
              const SizedBox(height: 20),
              _buildLegalSection(context, loc, theme),
              const SizedBox(height: 40),
              _buildLogoutBtn(context, loc, theme),
              const SizedBox(height: 20),
              _buildDeleteAccountBtn(context, loc, theme),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountSection(
      BuildContext context, AppLocalizations loc, ThemeData theme) {
    return SettingsContainer(
      sectionLabel: loc.lbAccount,
      options: [
        SettingsOptionItem(
          icon: AppIcons.user,
          title: loc.lbPersonalInfo,
          onTap: () => _navigateToPage(AppRoutes.settingsProfile),
        ),
        const SizedBox(height: 8),
        SettingsOptionItem(
          icon: AppIcons.analytics,
          title: loc.lbBudgetInfo,
          onTap: () => _navigateToPage(AppRoutes.settingsBudget),
        ),
        const SizedBox(height: 8),
        SettingsOptionItem(
          icon: AppIcons.code,
          title: loc.lbManageData,
          onTap: () => _navigateToPage(AppRoutes.settingsData),
        ),
      ],
    );
  }

  Widget _buildPreferencesSection(
      BuildContext context, AppLocalizations loc, ThemeData theme) {
    return SettingsContainer(
      sectionLabel: loc.lbPreferences,
      options: [
        SettingsOptionItem(
          icon: AppIcons.bell,
          title: loc.lbNotifications,
          onTap: () => _navigateToPage(AppRoutes.settingsNotifications),
        ),
        const SizedBox(height: 8),
        SettingsOptionItem(
          icon: AppIcons.palette,
          title: loc.lbAppearance,
          onTap: () => _navigateToPage(AppRoutes.settingsAppearance),
        ),
      ],
    );
  }

  Widget _buildSecuritySection(
      BuildContext context, AppLocalizations loc, ThemeData theme) {
    return SettingsContainer(
      sectionLabel: loc.lbSecurity,
      options: [
        SettingsOptionItem(
          icon: AppIcons.lock,
          title: loc.lbChangePassword,
          onTap: () => _navigateToPage(AppRoutes.settingsPassword),
        ),
      ],
    );
  }

  Widget _buildSupportSection(
      BuildContext context, AppLocalizations loc, ThemeData theme) {
    return SettingsContainer(
      sectionLabel: loc.lbSupport,
      options: [
        SettingsOptionItem(
          icon: AppIcons.help,
          title: loc.lbHelpCenter,
          onTap: () => _navigateToPage(AppRoutes.settingsHelper),
        ),
        const SizedBox(height: 8),
        SettingsOptionItem(
          icon: AppIcons.feedback,
          title: loc.lbSendFeedback,
          onTap: () => _navigateToPage(AppRoutes.settingsFeedback),
        ),
      ],
    );
  }

  Widget _buildLegalSection(
      BuildContext context, AppLocalizations loc, ThemeData theme) {
    return SettingsContainer(
      sectionLabel: loc.lbAboutLegal,
      options: [
        SettingsOptionItem(
          icon: AppIcons.fileLines,
          title: loc.lbTermsOfService,
          onTap: () => _navigateToPage(AppRoutes.settingsTerms),
        ),
        const SizedBox(height: 8),
        SettingsOptionItem(
          icon: AppIcons.privacy,
          title: loc.lbPrivacyPolicy,
          onTap: () => _navigateToPage(AppRoutes.settingsPrivacy),
        ),
      ],
    );
  }

  Widget _buildLogoutBtn(
      BuildContext context, AppLocalizations loc, ThemeData theme) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.secondaryContainer,
        foregroundColor: theme.colorScheme.onSecondaryContainer,
      ),
      child: Text(loc.lbLogout),
      onPressed: () {
        context.read<AuthBloc>().add(LogOutEvent());
      },
    );
  }

  Widget _buildDeleteAccountBtn(
      BuildContext context, AppLocalizations loc, ThemeData theme) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.errorContainer,
        foregroundColor: theme.colorScheme.onErrorContainer,
      ),
      child: Text(loc.deleteAccount),
      onPressed: () {
        final state = context.read<SettingsBloc>().state;
        if (state is! SettingsLoadedState) return;
        context.read<UserBloc>().add(DeleteUserEvent(id: state.user.id));
      },
    );
  }

  void _navigateToPage(String pageRoute) {
    context.push(pageRoute);
  }
}

