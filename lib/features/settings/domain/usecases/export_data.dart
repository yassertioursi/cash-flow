import 'package:file_picker/file_picker.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/base_failure.dart';
import '../../../../core/io/backup_platform.dart' as bk;
import '../../../../core/services/backup_service.dart';
import '../../../wallet/data/datasources/base_wallet_local_data_source.dart';

class ExportData {
  final BackupService _backupService;
  final BaseWalletLocalDataSource _walletDataSource;

  ExportData({
    required BackupService backupService,
    required BaseWalletLocalDataSource walletDataSource,
  })  : _backupService = backupService,
        _walletDataSource = walletDataSource;

  Future<Either<BaseFailure, String>> call({
    required String userId,
    String? password,
  }) async {
    try {

      final transactions = await _walletDataSource.getLastTransactions();
      final transactionMaps = transactions.map((t) => t.toJson()).toList();

      final backupJson = _backupService.exportToJson(
        userId: userId,
        transactions: transactionMaps,
        password: password,
      );

      final isEncrypted = password != null && password.isNotEmpty;
      final extension = isEncrypted ? 'ewb' : 'json';
      final timestamp = DateTime.now()
          .toIso8601String()
          .replaceAll(':', '-')
          .split('.')
          .first;
      final fileName = 'cashflow_backup_$timestamp.$extension';

      final result = await FilePicker.platform.saveFile(
        dialogTitle: 'Save Backup',
        fileName: fileName,
        type: FileType.custom,
        allowedExtensions: [extension],
        bytes: null,
      );

      if (result == null) {
        return Left(CancelledFailure('Export cancelled by user'));
      }

      await bk.writeFileAsString(result, backupJson);

      return Right(result);
    } catch (e) {
      return Left(UnknownFailure('Failed to export data: $e'));
    }
  }
}

class CancelledFailure extends BaseFailure {
  const CancelledFailure(super.message);
}
