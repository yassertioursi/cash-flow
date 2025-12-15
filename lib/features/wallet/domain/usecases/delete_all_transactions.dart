import 'package:cashflow/core/errors/base_failure.dart';
import 'package:cashflow/core/usecases/base_usecase.dart';
import 'package:cashflow/features/wallet/domain/repositories/base_wallet_repository.dart';
import 'package:fpdart/fpdart.dart';

class DeleteAllTransactions implements BaseUsecase<Unit, String> {
  final BaseWalletRepository repository;

  DeleteAllTransactions(this.repository);

  @override
  Future<Either<BaseFailure, Unit>> call(String userId) {
    return repository.deleteAllTransactions(userId);
  }
}
