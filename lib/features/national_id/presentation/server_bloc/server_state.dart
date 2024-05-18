part of 'server_bloc.dart';

@immutable
abstract class ServerState extends Equatable{

  const ServerState();

  @override
  List<Object> get props => [];
}

class ServerInitial extends ServerState {}

class LoadingState extends ServerState{}

class LoadedState extends ServerState{

}

class AuthErrorState extends ServerState{
  final String errorMsg;

  const AuthErrorState({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}