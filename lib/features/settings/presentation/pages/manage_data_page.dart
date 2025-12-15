import 'package:cashflow/core/io/backup_platform.dart' as bk;
import 'package:cashflow/core/presentation/widgets/icon_button_field.dart';
import 'package:cashflow/core/utils/transaction_parsing.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/settings_bloc.dart';
import '../widgets/export_dialog.dart';
import '../widgets/import_dialog.dart';
import '../widgets/settings_widgets.dart';
import '../../domain/usecases/import_data.dart';
import '../../domain/enums/backup_frequency.dart';
import '../../domain/entities/data_preferences.dart';
import '../../../user/presentation/bloc/user_bloc.dart';
import '../../../wallet/data/models/transaction_model.dart';
import '../../../wallet/presentation/bloc/wallet_bloc.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/services/backup_service.dart';
import '../../../../core/presentation/widgets/core_widgets.dart';
import 'package:cashflow/core/theme/app_icons.dart';

class ManageDataPage extends StatefulWidget {
  const ManageDataPage({super.key});

  @override
  State<ManageDataPage> createState() => _ManageDataPageState();
}

class _ManageDataPageState extends State<ManageDataPage> {
  DataPreferences _currentPreferences = DataPreferences();
  DataPreferences _initialPreferences = DataPreferences();

  bool _pendingChanges = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final settingsState = context.read<SettingsBloc>().state;
    if (settingsState is SettingsLoadedState) {
      final settings = settingsState.preferences.dataPreferences;
      _currentPreferences = settings.copyWith();
      _initialPreferences = settings.copyWith();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;

    return BlocBuilder<SettingsBloc, BaseSettingsState>(
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
          return Scaffold(
              body: Stack(
                children: [
                  Column(
                    children: [
                      SettingsSubPageHeader(
                        title: loc.lbManageData,
                        subtitle: loc.manageDataSubTitle,
                        complement: null,
                      ),
                      const SizedBox(height: 24),
                      Expanded(
                        child: SettingsCard(
                          child: _buildDataOptions(context, theme, loc),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                  SettingsConfirmEditionBtn(
                    onPressed: (ctx) => _submitChanges(ctx),
                    pendingChanges: _pendingChanges,
                  ),
                ],
              ));
        }

        return SizedBox.shrink();
      },
    );
  }

  Widget _buildDataOptions(
      BuildContext context, ThemeData theme, AppLocalizations loc) {
    final sections = [
      _buildDataSection(context, theme, loc),
      _buildBackupSection(context, theme, loc),
    ];

    return SettingsSectionList(sections: sections, theme: theme);
  }

  Widget _buildDataSection(
      BuildContext context, ThemeData theme, AppLocalizations loc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        SettingsSectionTitle(title: loc.sectionDataManagement),
        const SizedBox(height: 16),
        IconButtonField(
          icon: AppIcons.uploadFile,
          title: loc.lbExportData,
          subtitle: loc.exportDataDescription,
          onPressed: () => _showExportDialog(context, loc),
        ),
        const SizedBox(height: 16),
        IconButtonField(
          icon: AppIcons.download,
          title: loc.lbImport,
          subtitle: loc.importDataDescription,
          onPressed: () => _showImportFlow(context, loc),
        ),
        const SizedBox(height: 16),
        IconButtonField(
          icon: AppIcons.deleteForever,
          title: loc.lbDelete,
          subtitle: loc.deleteDataDescription,
          onPressed: () => _deleteAction(context, theme, loc),
          color: theme.colorScheme.error,
        ),
      ],
    );
  }

  void _deleteAction(
      BuildContext context, ThemeData theme, AppLocalizations loc) {
    final userBloc = context.read<UserBloc>();
    final walletBloc = context.read<WalletBloc>();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(loc.confirmDeleteDataTitle),
          content: Text(loc.askConfirmDeleteData),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text(loc.btnCancel),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                final userId = (userBloc.state as UserLoadedState).user.id;
                walletBloc.add(DeleteAllTransactionsEvent(userId));

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(loc.msgTransactionDeleted)),
                );
              },
              child: Text(
                loc.lbDelete,
                style: TextStyle(color: theme.colorScheme.error),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBackupSection(
      BuildContext context, ThemeData theme, AppLocalizations loc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsSectionTitle(title: loc.sectionBackup),

        const SizedBox(height: 8),
        SwitchRow(
          icon: AppIcons.lock,
          label: loc.lbEncrypted,
          value:
              _currentPreferences.encryptedBackup,
          onChanged: (bool newValue) {
            setState(() {
              _currentPreferences = _currentPreferences.copyWith(
                encryptedBackup: newValue,
              );
              _pendingChanges = _currentPreferences != _initialPreferences;
            });
          },
          theme: theme,
        ),
        const SizedBox(height: 8),
        DropdownRow<BackupFrequency>(
          icon: AppIcons.clock,
          label: loc.lbFrequency,
          value: _currentPreferences.backupFrequency,
          items: [
            DropdownMenuItem(
                value: BackupFrequency.none, child: Text(loc.frequencyNone)),
            DropdownMenuItem(
                value: BackupFrequency.daily, child: Text(loc.frequencyDaily)),
            DropdownMenuItem(
                value: BackupFrequency.weekly,
                child: Text(loc.frequencyWeekly)),
            DropdownMenuItem(
                value: BackupFrequency.monthly,
                child: Text(loc.frequencyMonthly)),
          ],
          onChanged: (BackupFrequency? newValue) {
            setState(() {
              _currentPreferences = _currentPreferences.copyWith(
                backupFrequency: newValue ?? BackupFrequency.none,
              );
              _pendingChanges = _currentPreferences != _initialPreferences;
            });
          },
          theme: theme,
        )
      ],
    );
  }

  Future<void> _showExportDialog(
      BuildContext context, AppLocalizations loc) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (ctx) => ExportDialog(
        defaultEncrypted: _currentPreferences.encryptedBackup,
      ),
    );

    if (!context.mounted) return;
    if (result == null) {
      _showSnackBar(context, loc.exportCancelled);
      return;
    }

    final encrypted = result['encrypted'] as bool;
    final password = result['password'] as String?;

    final userBloc = context.read<UserBloc>();
    if (userBloc.state is! UserLoadedState) return;
    final userId = (userBloc.state as UserLoadedState).user.id;

    final walletState = context.read<WalletBloc>().state;
    if (walletState is! WalletLoaded) return;

    final transactions = walletState.transactions
        .map((t) => TransactionModel.fromEntity(t).toJson())
        .toList();

    final backupService = BackupService();
    final backupJson = backupService.exportToJson(
      userId: userId,
      transactions: transactions,
      password: encrypted ? password : null,
    );

    final extension = encrypted ? 'ewb' : 'json';
    final timestamp =
        DateTime.now().toIso8601String().replaceAll(':', '-').split('.').first;
    final fileName = 'cashflow_backup_$timestamp.$extension';

    final savePath = await FilePicker.platform.saveFile(
      dialogTitle: loc.lbExport,
      fileName: fileName,
      type: FileType.custom,
      allowedExtensions: [extension],
    );

    if (savePath == null) {
      if (!context.mounted) return;
      _showSnackBar(context, loc.exportCancelled);
      return;
    }

    await bk.writeFileAsString(savePath, backupJson);

    if (!context.mounted) return;
    _showSnackBar(context, loc.exportSuccess);
  }

  Future<void> _showImportFlow(
      BuildContext context, AppLocalizations loc) async {

    final result = await FilePicker.platform.pickFiles(
      dialogTitle: loc.lbImport,
      type: FileType.custom,
      allowedExtensions: ['json', 'ewb'],
    );

    if (result == null || result.files.isEmpty) {
      if (!context.mounted) return;
      _showSnackBar(context, loc.importCancelled);
      return;
    }

    String content;
    final filePath = result.files.first.path;
    if (filePath != null) {
      content = await bk.readFileAsString(filePath);
    } else {
      final bytes = result.files.first.bytes;
      if (bytes == null) {
        if (!context.mounted) return;
        _showSnackBar(context, loc.importError);
        return;
      }
      content = String.fromCharCodes(bytes);
    }

    if (!context.mounted) return;
    final backupService = BackupService();
    final isEncrypted = backupService.isEncrypted(content);

    final options = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (ctx) => ImportDialog(isEncrypted: isEncrypted),
    );

    if (!context.mounted) return;
    if (options == null) {
      _showSnackBar(context, loc.importCancelled);
      return;
    }

    final mode = options['mode'] as ImportMode;
    final password = options['password'] as String?;

    final userBloc = context.read<UserBloc>();
    if (userBloc.state is! UserLoadedState) return;
    final userId = (userBloc.state as UserLoadedState).user.id;

    try {
      final backupData =
          backupService.importFromJson(content, password: password);

      if (!backupService.validateBackup(backupData)) {
        if (!context.mounted) return;
        _showSnackBar(context, loc.importError);
        return;
      }

      final walletBloc = context.read<WalletBloc>();

      if (mode == ImportMode.replace) {
        walletBloc.add(DeleteAllTransactionsEvent(userId));
        await Future.delayed(const Duration(milliseconds: 500));
        if (!context.mounted) return;
      }

      int importedCount = 0;
      for (final txJson in backupData.transactions) {
        try {
          final transaction =
              TransactionParsingUtils.parseTransactionFromJson(txJson, userId);
          walletBloc.add(AddTransactionEvent(1, transaction));
          importedCount++;
        } catch (_) {}
      }

      if (!context.mounted) return;
      _showSnackBar(context, loc.importSuccess(importedCount));

      walletBloc.add(LoadWalletDataEvent());
    } catch (e) {
      if (!context.mounted) return;
      _showSnackBar(context, loc.importError);
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _submitChanges(BuildContext context) {
    if (!_pendingChanges) return;

    final settingsState = context.read<SettingsBloc>().state;
    if (settingsState is! SettingsLoadedState) return;

    final newPreferences = settingsState.preferences
        .copyWith(dataPreferences: _currentPreferences);
    _pendingChanges = false;

    context
        .read<SettingsBloc>()
        .add(UpdateUserPreferencesEvent(userPreferences: newPreferences));
  }
}

