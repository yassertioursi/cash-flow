import 'package:fpdart/fpdart.dart';
import 'package:cashflow/core/errors/base_failure.dart';

abstract class BaseUsecase<TResult, Params> {
  Future<Either<BaseFailure, TResult>> call(Params params);
}

class NoParams {}
