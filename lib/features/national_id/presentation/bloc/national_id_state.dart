part of 'national_id_bloc.dart';

@immutable
abstract class NationalIdState extends Equatable{
  const NationalIdState();

  @override
  List<Object> get props => [];
}

class NationalIdInitial extends NationalIdState {}

class LoadingNationalIdState extends NationalIdState{}

class LoadedNationalIdState extends NationalIdState{
  final NationalIdEntity nationalId;

  const LoadedNationalIdState({required this.nationalId});

  @override
  List<Object> get props => [nationalId];
}


class NationalIdErrorState extends NationalIdState{
  final String errorMsg;

  const NationalIdErrorState({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}