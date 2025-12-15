import 'package:fpdart/fpdart.dart';

import 'package:cashflow/core/errors/base_failure.dart';
import 'package:cashflow/core/usecases/base_usecase.dart';

import '../repositories/base_wallet_repository.dart';

class DeleteTransaction implements BaseUsecase<Unit, String> {
  final BaseWalletRepository repository;

  DeleteTransaction(this.repository);

  @override
  Future<Either<BaseFailure, Unit>> call(String transactionId) {
    return repository.deleteTransaction(transactionId);
  }
}
