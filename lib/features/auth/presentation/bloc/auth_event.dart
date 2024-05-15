part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable{
  const AuthEvent();

  @override
  List<Object>get props => [];
}

class RegisterEvent extends AuthEvent {
  final UserEntity newUser;

  const RegisterEvent({required this.newUser});

  @override
  List<Object> get props => [newUser];
}

class LoginEvent extends AuthEvent {
  final String emailOrUserName;
  final String password;

  const LoginEvent({required this.emailOrUserName,required this.password});

  @override
  List<Object> get props => [emailOrUserName,password];
}

class GetUserEvent extends AuthEvent {
  final String username;
  final String userToken;

  const GetUserEvent({required this.username, required this.userToken});

  @override
  List<Object> get props => [username,userToken];
}
