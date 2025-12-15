import 'package:go_router/go_router.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cashflow/core/utils/app_validators.dart';
import 'package:cashflow/core/theme/glass_surface.dart';

import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/presentation/widgets/or_divider.dart';
import '../../../../core/presentation/widgets/any_text_field.dart';
import '../../../../core/presentation/widgets/password_field.dart';
import 'package:cashflow/core/theme/app_icons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;

    return BlocListener<AuthBloc, BaseAuthState>(
      listener: (context, state) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();

        if (state is AuthErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message ?? loc.loginErrorGeneric),
              backgroundColor: theme.colorScheme.error,
              duration: const Duration(seconds: 4),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 460),
                    child: GlassSurface(
                      radius: 28,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildHeader(theme, loc),
                          const SizedBox(height: 24),
                          _buildFields(context, theme, loc),
                          const SizedBox(height: 12),
                          _buildSignInBtn(theme, loc),
                          _buildFooter(theme, loc),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              _buildWaningTerms(theme, loc),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme, AppLocalizations loc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 24),
        Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                'assets/logo-nbg.png',
                height: 84,
                width: 84,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              loc.appTitle,
              style: theme.textTheme.headlineMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              loc.loginWelcomeMessage,
              style: theme.textTheme.bodyMedium?.copyWith(
                color:
                    theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          loc.welcomeBack,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildFields(
      BuildContext context, ThemeData theme, AppLocalizations loc) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AnyTextField(
            label: loc.lbEmail,
            hintText: loc.hintEmail,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (value) => AppValidators.isValidEmail(loc, value),
            inisidePrefixIcon: Icon(
              AppIcons.email,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 12),
          PasswordField(
            label: loc.lbPassword,
            hintText: loc.hintPassword,
            obscureText: _obscurePassword,
            controller: _passwordController,
            onToggleObscureText: () => setState(() {
              _obscurePassword = !_obscurePassword;
            }),
            validator: (value) => AppValidators.isValidPassword(loc, value),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(loc.msgFeatureComingSoon),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              child: Text(
                loc.askForgotPassword,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignInBtn(ThemeData theme, AppLocalizations loc) {
    return ElevatedButton(
      onPressed: _submitLogin,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          loc.lbSignIn,
          style: theme.textTheme.labelLarge?.copyWith(
            color: theme.colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(ThemeData theme, AppLocalizations loc) {
    return Column(
      children: [
        const SizedBox(height: 16),
        const OrDivider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              loc.askDontHaveAccount,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            TextButton(
              onPressed: () => context.push(AppRoutes.register),
              child: Text(
                loc.lbSignUp,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildWaningTerms(ThemeData theme, AppLocalizations loc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Text(
        loc.loginWarningTerms,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  void _submitLogin() {
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthBloc>().add(
          SignInEvent(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          ),
        );
  }
}

