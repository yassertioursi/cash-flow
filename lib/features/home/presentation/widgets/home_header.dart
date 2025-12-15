import 'package:cashflow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cashflow/core/theme/app_icons.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.welcomeText,
    required this.titleText,
  });

  final String welcomeText;
  final String titleText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              welcomeText,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              titleText,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            context.read<AuthBloc>().add(LogOutEvent());
          },
          icon: Icon(
            AppIcons.logout,
            color: theme.colorScheme.onPrimaryContainer,
          ),
        )
      ],
    );
  }
}

