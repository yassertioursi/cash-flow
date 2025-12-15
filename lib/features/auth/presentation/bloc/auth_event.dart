part of 'auth_bloc.dart';

abstract class BaseAuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppStartedEvent extends BaseAuthEvent {}

class SignInEvent extends BaseAuthEvent {
  final String email;
  final String password;

  SignInEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class SignUpEvent extends BaseAuthEvent {
  final String name;
  final String email;
  final String password;

  SignUpEvent({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [name, email, password];
}

class LogOutEvent extends BaseAuthEvent {}

class CheckAuthStatusEvent extends BaseAuthEvent {}
