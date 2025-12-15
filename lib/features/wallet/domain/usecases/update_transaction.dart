import 'package:cashflow/core/errors/base_failure.dart';
import 'package:fpdart/fpdart.dart';

import 'package:cashflow/core/usecases/base_usecase.dart';
import 'package:cashflow/features/wallet/domain/entities/transaction.dart';

import '../repositories/base_wallet_repository.dart';

class UpdateTransaction implements BaseUsecase<Unit, Transaction> {
  final BaseWalletRepository repository;

  UpdateTransaction(this.repository);

  @override
  Future<Either<BaseFailure, Unit>> call(Transaction transaction) async {
    final result = await repository.updateTransaction(transaction);
    return result.map((_) => unit);
  }
}
