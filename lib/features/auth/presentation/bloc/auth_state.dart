part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class LoadingState extends AuthState {

}

class LoadedState extends AuthState {

}

class ErrorState extends AuthState{
  final String errorMsg;

  const ErrorState({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}