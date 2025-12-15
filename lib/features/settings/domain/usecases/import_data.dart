import 'package:file_picker/file_picker.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/base_failure.dart';
import '../../../../core/io/backup_platform.dart' as bk;
import '../../../../core/services/backup_service.dart';
import '../../../wallet/data/datasources/base_wallet_local_data_source.dart';
import '../../../wallet/data/models/transaction_model.dart';
import '../../../wallet/domain/entities/transaction.dart';
import '../../../../core/enums/enums.dart';
import '../../../../core/database/db_seeds.dart';

class ImportResult {
  final int importedCount;
  final int skippedCount;
  final int errorCount;

  const ImportResult({
    required this.importedCount,
    this.skippedCount = 0,
    this.errorCount = 0,
  });

  int get totalProcessed => importedCount + skippedCount + errorCount;
}

enum ImportMode {

  replace,

  merge,
}

class ImportData {
  final BackupService _backupService;
  final BaseWalletLocalDataSource _walletDataSource;

  ImportData({
    required BackupService backupService,
    required BaseWalletLocalDataSource walletDataSource,
  })  : _backupService = backupService,
        _walletDataSource = walletDataSource;

  Future<Either<BaseFailure, ImportResult>> call({
    required String userId,
    required ImportMode mode,
    String? password,
  }) async {
    try {

      final result = await FilePicker.platform.pickFiles(
        dialogTitle: 'Select Backup File',
        type: FileType.custom,
        allowedExtensions: ['json', 'ewb'],
      );

      if (result == null || result.files.isEmpty) {
        return Left(CancelledFailure('Import cancelled by user'));
      }

      final filePath = result.files.first.path;
      String content;
      if (filePath != null) {
        content = await bk.readFileAsString(filePath);
      } else {
        final bytes = result.files.first.bytes;
        if (bytes == null) {
          return Left(UnknownFailure('Could not read file content'));
        }
        content = String.fromCharCodes(bytes);
      }

      if (_backupService.isEncrypted(content)) {
        if (password == null || password.isEmpty) {
          return Left(PasswordRequiredFailure('This backup is encrypted. Please provide a password.'));
        }
      }

      final BackupData backupData;
      try {
        backupData = _backupService.importFromJson(content, password: password);
      } on FormatException catch (e) {
        return Left(InvalidBackupFailure(e.message));
      }

      if (!_backupService.validateBackup(backupData)) {
        return Left(InvalidBackupFailure('Backup file is invalid or corrupted'));
      }

      return await _processImport(
        backupData: backupData,
        userId: userId,
        mode: mode,
      );
    } catch (e) {
      return Left(UnknownFailure('Failed to import data: $e'));
    }
  }

  Future<Either<BaseFailure, ImportResult>> _processImport({
    required BackupData backupData,
    required String userId,
    required ImportMode mode,
  }) async {
    try {
      if (mode == ImportMode.replace) {

        await _walletDataSource.deleteAllTransactions(userId);
      }

      Set<String> existingIds = {};
      if (mode == ImportMode.merge) {
        final existing = await _walletDataSource.getLastTransactions();
        existingIds = existing.map((t) => t.id).toSet();
      }

      int importedCount = 0;
      int skippedCount = 0;
      int errorCount = 0;

      for (final txJson in backupData.transactions) {
        try {
          final transactionId = txJson['id'] as String;

          if (mode == ImportMode.merge && existingIds.contains(transactionId)) {
            skippedCount++;
            continue;
          }

          final transaction = _parseTransaction(txJson, userId);
          final model = TransactionModel.fromEntity(transaction);
          await _walletDataSource.cacheTransaction(model);
          importedCount++;
        } catch (e) {
          errorCount++;
        }
      }

      return Right(ImportResult(
        importedCount: importedCount,
        skippedCount: skippedCount,
        errorCount: errorCount,
      ));
    } catch (e) {
      return Left(UnknownFailure('Failed to process import: $e'));
    }
  }

  Transaction _parseTransaction(Map<String, dynamic> json, String userId) {

    ETransactionType type;
    final rawType = json['type_id'] ?? json['type'];
    if (rawType is int) {
      type = rawType == 1 ? ETransactionType.income : ETransactionType.expense;
    } else {
      final typeStr = rawType?.toString() ?? 'expense';
      type = typeStr == 'income' ? ETransactionType.income : ETransactionType.expense;
    }

    ETransactionCategory category;
    final rawCategory = json['category_id'] ?? json['category'];
    if (rawCategory is int) {
      final categoryName = DbSeeds.getCategoryName(rawCategory);
      category = ETransactionCategory.values.firstWhere(
        (e) => e.name == categoryName,
        orElse: () => ETransactionCategory.others,
      );
    } else {
      final catStr = rawCategory?.toString() ?? 'others';
      category = ETransactionCategory.values.firstWhere(
        (e) => e.name == catStr || e.toString() == catStr,
        orElse: () => ETransactionCategory.others,
      );
    }

    int amountCents;
    if (json.containsKey('amount_cents')) {
      amountCents = json['amount_cents'] as int;
    } else {
      final amount = json['amount'] as int? ?? 0;
      final cents = json['cents'] as int? ?? 0;
      amountCents = amount * 100 + cents;
    }

    return Transaction(
      id: json['id'] as String,
      userId: userId,
      name: json['name'] as String,
      amountCents: amountCents,
      date: DateTime.parse(json['date'] as String),
      type: type,
      category: category,
    );
  }
}

class PasswordRequiredFailure extends BaseFailure {
  const PasswordRequiredFailure(super.message);
}

class InvalidBackupFailure extends BaseFailure {
  const InvalidBackupFailure(super.message);
}

class CancelledFailure extends BaseFailure {
  const CancelledFailure(super.message);
}
