import 'package:cashflow/core/errors/base_failure.dart';
import 'package:cashflow/core/usecases/base_usecase.dart';
import 'package:cashflow/features/wallet/domain/repositories/base_wallet_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetMonthlySavings implements BaseUsecase<double, int> {
  final BaseWalletRepository repository;

  GetMonthlySavings(this.repository);

  @override
  Future<Either<BaseFailure, double>> call(int initialDay) {
    return repository.getMonthlySavings(initialDay);
  }
}
