part of 'server_bloc.dart';

@immutable
abstract class ServerEvent extends Equatable{
  const ServerEvent();

  @override
  List<Object>get props => [];
}

class GetServerLinkEvent extends ServerEvent{
  final ServerEntity serverEntity;

  const GetServerLinkEvent({required this.serverEntity});

  @override
  List<Object> get props => [serverEntity];
}