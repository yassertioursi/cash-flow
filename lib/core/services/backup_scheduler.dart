import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/settings/domain/enums/backup_frequency.dart';
import '../io/backup_platform.dart' as bk;
import 'backup_service.dart';

class BackupScheduler {
  static const String _lastBackupKey = 'last_backup_date';
  static const String _backupFolderName = 'backups';

  final BackupService _backupService;

  BackupScheduler({required BackupService backupService})
      : _backupService = backupService;

  Future<bool> isBackupDue(BackupFrequency frequency) async {
    if (frequency == BackupFrequency.none) return false;

    final lastBackup = await getLastBackupDate();
    if (lastBackup == null) return true;

    final now = DateTime.now();
    final difference = now.difference(lastBackup);

    switch (frequency) {
      case BackupFrequency.daily:
        return difference.inDays >= 1;
      case BackupFrequency.weekly:
        return difference.inDays >= 7;
      case BackupFrequency.monthly:
        return difference.inDays >= 30;
      case BackupFrequency.none:
        return false;
    }
  }

  Future<String?> performAutoBackupIfDue({
    required BackupFrequency frequency,
    required String userId,
    required List<Map<String, dynamic>> transactions,
    Map<String, dynamic>? settings,
    String? encryptionPassword,
  }) async {
    if (!await isBackupDue(frequency)) return null;

    return await performBackup(
      userId: userId,
      transactions: transactions,
      settings: settings,
      password: encryptionPassword,
    );
  }

  Future<String> performBackup({
    required String userId,
    required List<Map<String, dynamic>> transactions,
    Map<String, dynamic>? settings,
    String? password,
  }) async {
    final backupData = _backupService.exportToJson(
      userId: userId,
      transactions: transactions,
      settings: settings,
      password: password,
    );

    final filePath = await _saveBackupToFile(backupData, userId);
    await _updateLastBackupDate();

    return filePath;
  }

  Future<DateTime?> getLastBackupDate() async {
    final prefs = await SharedPreferences.getInstance();
    final timestamp = prefs.getInt(_lastBackupKey);
    if (timestamp == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  Future<String> getBackupDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    final backupDir = p.join(appDir.path, _backupFolderName);

    await bk.createDirectory(backupDir);

    return backupDir;
  }

  Future<List<String>> listBackups() async {
    final backupDir = await getBackupDirectory();
    return bk.listBackupFiles(backupDir);
  }

  Future<void> cleanupOldBackups({int keepCount = 5}) async {
    final backups = await listBackups();

    if (backups.length <= keepCount) return;

    for (var i = keepCount; i < backups.length; i++) {
      await bk.deleteFile(backups[i]);
    }
  }

  Future<String> _saveBackupToFile(String data, String userId) async {
    final backupDir = await getBackupDirectory();
    final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-');
    final extension = data.startsWith('EW_ENCRYPTED:') ? 'ewb' : 'json';
    final fileName = 'backup_$timestamp.$extension';
    final filePath = p.join(backupDir, fileName);

    await bk.writeFileAsString(filePath, data);

    await cleanupOldBackups();

    return filePath;
  }

  Future<void> _updateLastBackupDate() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lastBackupKey, DateTime.now().millisecondsSinceEpoch);
  }
}
