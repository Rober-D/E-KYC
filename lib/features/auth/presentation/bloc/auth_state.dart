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

class AuthErrorState extends AuthState{
  final String errorMsg;

  const AuthErrorState({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}