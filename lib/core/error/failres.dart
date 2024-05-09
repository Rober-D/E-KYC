import 'package:equatable/equatable.dart';

abstract class Failures extends Equatable{}

class NetworkFailure extends Failures{
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failures{
  @override
  List<Object?> get props => [];
}

class APIFailure extends Failures{
  @override
  List<Object?> get props => [];
}