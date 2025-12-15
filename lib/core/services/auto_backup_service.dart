import 'package:flutter/foundation.dart';

import '../../../features/settings/domain/entities/data_preferences.dart';
import '../../../features/wallet/data/models/transaction_model.dart';
import '../../../features/wallet/domain/entities/transaction.dart';
import 'backup_scheduler.dart';
import 'backup_service.dart';

class AutoBackupService {
  final BackupScheduler _scheduler;

  AutoBackupService({BackupScheduler? scheduler})
      : _scheduler = scheduler ??
            BackupScheduler(backupService: BackupService());

  Future<String?> checkAndPerformBackupIfDue({
    required String userId,
    required List<Transaction> transactions,
    required DataPreferences dataPreferences,
  }) async {
    if (kIsWeb) return null;

    try {

      if (!await _scheduler.isBackupDue(dataPreferences.backupFrequency)) {
        debugPrint('[AutoBackup] Backup not due yet');
        return null;
      }

      debugPrint('[AutoBackup] Backup is due, performing backup...');

      final transactionMaps = transactions
          .map((t) => TransactionModel.fromEntity(t).toJson())
          .toList();

      final filePath = await _scheduler.performBackup(
        userId: userId,
        transactions: transactionMaps,
        password: dataPreferences.encryptedBackup ? _generateAutoBackupPassword(userId) : null,
      );

      debugPrint('[AutoBackup] Backup completed: $filePath');
      return filePath;
    } catch (e) {
      debugPrint('[AutoBackup] Backup failed: $e');
      return null;
    }
  }

  Future<DateTime?> getLastBackupDate() async {
    return await _scheduler.getLastBackupDate();
  }

  String _generateAutoBackupPassword(String userId) {

    return 'auto_${userId.hashCode.abs()}';
  }
}
