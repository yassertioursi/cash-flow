import 'package:equatable/equatable.dart';

abstract class BaseFailure extends Equatable {
  final String? message;

  const BaseFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends BaseFailure {
  const ServerFailure(super.message);
}

class CacheFailure extends BaseFailure {
  const CacheFailure(super.message);
}

class NetworkFailure extends BaseFailure {
  const NetworkFailure(super.message);
}

class AuthenticationFailure extends BaseFailure {
  const AuthenticationFailure(super.message);
}

class ValidationFailure extends BaseFailure {
  const ValidationFailure(super.message);
}

class UnknownFailure extends BaseFailure {
  const UnknownFailure(super.message);
}
