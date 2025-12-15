import 'package:flutter/material.dart';

class NotificationOptionRow extends StatelessWidget {
  const NotificationOptionRow({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
    this.description,
    this.trailing,
  });

  final IconData icon;

  final String title;

  final String? description;

  final bool value;

  final ValueChanged<bool> onChanged;

  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(icon, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
              if (description != null)
                Text(
                  description!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
            ],
          ),
        ),
        Switch(value: value, onChanged: onChanged),
        if (trailing != null) trailing!,
      ],
    );
  }
}
