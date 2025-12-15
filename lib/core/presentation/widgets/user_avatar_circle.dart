import 'package:flutter/material.dart';
import 'package:cashflow/core/theme/app_icons.dart';

class UserAvatarCircle extends StatelessWidget {
  const UserAvatarCircle({
    super.key,
    required this.imageUrl,
    this.radius = 32,
    this.iconSize = 40,
  });

  final String? imageUrl;

  final double radius;

  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CircleAvatar(
      radius: radius,
      backgroundColor: theme.colorScheme.primary.withAlpha(50),
      child: imageUrl != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: Image.network(
                imageUrl!,
                width: radius * 2,
                height: radius * 2,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildPlaceholder(theme);
                },
              ),
            )
          : _buildPlaceholder(theme),
    );
  }

  Widget _buildPlaceholder(ThemeData theme) {
    return Icon(
      AppIcons.userCircle,
      color: theme.colorScheme.primary,
      size: iconSize,
    );
  }
}

