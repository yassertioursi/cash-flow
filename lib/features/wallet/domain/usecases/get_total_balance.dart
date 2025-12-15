import 'package:cashflow/core/errors/base_failure.dart';
import 'package:cashflow/core/usecases/base_usecase.dart';
import 'package:cashflow/features/wallet/domain/repositories/base_wallet_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetTotalBalance implements BaseUsecase<double, NoParams> {
  final BaseWalletRepository repository;

  GetTotalBalance(this.repository);

  @override
  Future<Either<BaseFailure, double>> call(NoParams params) {
    return repository.getTotalBalance();
  }
}
