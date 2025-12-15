import 'package:cashflow/core/errors/base_failure.dart';
import 'package:cashflow/core/usecases/base_usecase.dart';
import 'package:cashflow/features/wallet/domain/repositories/base_wallet_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/transaction.dart';

class AddTransaction implements BaseUsecase<Unit, Transaction> {
  final BaseWalletRepository repository;

  AddTransaction(this.repository);

  @override
  Future<Either<BaseFailure, Unit>> call(Transaction transaction) async {
    final result = await repository.addTransaction(transaction);
    return result.map((_) => unit);
  }
}
