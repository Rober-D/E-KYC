part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable{
  const AuthEvent();

  @override
  List<Object>get props => [];
}

class RegisterEvent extends AuthEvent {}

class LoginEvent extends AuthEvent {
  final String emailOrUserName;
  final String password;

  const LoginEvent({required this.emailOrUserName,required this.password});

  @override
  List<Object> get props => [emailOrUserName,password];
}
