import 'package:cashflow/core/theme/glass_surface.dart';
import 'package:flutter/material.dart';

class SettingsContainer extends StatelessWidget {
  final String sectionLabel;
  final List<Widget> options;

  const SettingsContainer({
    super.key,
    required this.sectionLabel,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sectionLabel,
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 12),
        GlassSurface(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          radius: 20,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: options,
          ),
        ),
      ],
    );
  }
}
