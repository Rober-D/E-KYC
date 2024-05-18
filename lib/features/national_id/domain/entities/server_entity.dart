import 'package:equatable/equatable.dart';

class ServerEntity extends Equatable{
  String localHostServer;

  ServerEntity({required this.localHostServer});

  @override
  List<Object?> get props => throw UnimplementedError();

}