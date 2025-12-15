import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {

  final Widget child;

  final EdgeInsetsGeometry margin;

  final Clip clipBehavior;

  const SettingsCard({
    super.key,
    required this.child,
    this.margin = const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
    this.clipBehavior = Clip.hardEdge,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 8,
          ),
        ],
      ),
      margin: margin,
      clipBehavior: clipBehavior,
      child: child,
    );
  }
}
