import 'package:fpdart/fpdart.dart';

import 'package:cashflow/core/errors/base_failure.dart';
import 'package:cashflow/core/usecases/base_usecase.dart';

import '../entities/transaction.dart';
import '../repositories/base_wallet_repository.dart';

class GetTransaction implements BaseUsecase<Transaction, String> {
  final BaseWalletRepository repository;

  GetTransaction(this.repository);

  @override
  Future<Either<BaseFailure, Transaction>> call(String transactionId) {
    return repository.getTransactionById(transactionId);
  }
}
