import 'package:flutter/material.dart';

import '../widgets/settings_sub_page_header.dart';
import '../widgets/settings_section_list.dart';
import '../widgets/settings_section_title.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:cashflow/core/theme/app_icons.dart';

enum EFeedbackCategory { bug, suggestion, compliment, other }

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();
  final _emailController = TextEditingController();
  EFeedbackCategory _selectedCategory = EFeedbackCategory.suggestion;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _messageController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      body: Column(
        children: [
          SettingsSubPageHeader(
            title: loc.lbSendFeedback,
            subtitle: loc.feedbackSubTitle,
            complement: null,
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 4.0),
              clipBehavior: Clip.hardEdge,
              child: _buildFeedbackForm(context, theme, loc),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackForm(BuildContext context, ThemeData theme, AppLocalizations loc) {
    final sections = [
      _buildHeaderSection(theme, loc),
      _buildCategorySection(theme, loc),
      _buildMessageSection(theme, loc),
      _buildEmailSection(theme, loc),
      _buildSubmitSection(theme, loc),
    ];

    return Form(
      key: _formKey,
      child: SettingsSectionList(sections: sections, theme: theme),
    );
  }

  Widget _buildHeaderSection(ThemeData theme, AppLocalizations loc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                AppIcons.feedback,
                color: theme.colorScheme.onPrimaryContainer,
                size: 32,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loc.feedbackTitle,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    loc.feedbackDescription,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCategorySection(ThemeData theme, AppLocalizations loc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsSectionTitle(title: loc.feedbackCategoryLabel),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildCategoryChip(EFeedbackCategory.bug, AppIcons.bug, loc.feedbackCategoryBug, theme),
            _buildCategoryChip(
                EFeedbackCategory.suggestion, AppIcons.lightbulb, loc.feedbackCategorySuggestion, theme),
            _buildCategoryChip(
                EFeedbackCategory.compliment, AppIcons.thumbUp, loc.feedbackCategoryCompliment, theme),
            _buildCategoryChip(EFeedbackCategory.other, AppIcons.ellipsis, loc.feedbackCategoryOther, theme),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryChip(EFeedbackCategory category, IconData icon, String label, ThemeData theme) {
    final isSelected = _selectedCategory == category;
    return FilterChip(
      selected: isSelected,
      showCheckmark: false,
      avatar: Icon(
        icon,
        size: 18,
        color: isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.onSurfaceVariant,
      ),
      label: Text(label),
      labelStyle: TextStyle(
        color: isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface,
      ),
      backgroundColor: theme.colorScheme.surfaceContainerHighest,
      selectedColor: theme.colorScheme.primary,
      onSelected: (selected) {
        setState(() {
          _selectedCategory = category;
        });
      },
    );
  }

  Widget _buildMessageSection(ThemeData theme, AppLocalizations loc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsSectionTitle(title: loc.feedbackMessageLabel),
        const SizedBox(height: 12),
        TextFormField(
          controller: _messageController,
          maxLines: 5,
          maxLength: 500,
          decoration: InputDecoration(
            hintText: loc.feedbackMessageHint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return loc.errorEmpty;
            }
            return null;
          },
          onChanged: (value) {
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildEmailSection(ThemeData theme, AppLocalizations loc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsSectionTitle(title: loc.feedbackEmailLabel),
        const SizedBox(height: 12),
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: loc.feedbackEmailHint,
            prefixIcon: Icon(AppIcons.email),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitSection(ThemeData theme, AppLocalizations loc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: _isSubmitting ? null : _submitFeedback,
          icon: _isSubmitting
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: theme.colorScheme.onPrimary,
                  ),
                )
              : Icon(AppIcons.send),
          label: Text(loc.feedbackSubmitButton),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
    );
  }

  void _submitFeedback() {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      setState(() {
        _isSubmitting = false;
      });

      final loc = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(loc.feedbackThankYou),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );

      _messageController.clear();
      _emailController.clear();
    });
  }
}

