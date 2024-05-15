part of 'national_id_bloc.dart';

@immutable
abstract class NationalIdEvent extends Equatable{
  const NationalIdEvent();

  @override
  List<Object> get props => [];
}

class CreateNationalIdEvent extends NationalIdEvent{
  NationalIdEntity newNationalIdCard;
  String token;

  CreateNationalIdEvent({required this.newNationalIdCard, required this.token});

  @override
  List<Object> get props => [newNationalIdCard];
}

class UpdateNationalIdEvent extends NationalIdEvent{
  NationalIdEntity updatedNationalIdCard;
  String token;

  UpdateNationalIdEvent({required this.updatedNationalIdCard, required this.token});

  @override
  List<Object> get props => [updatedNationalIdCard];
}

class GetNationalIdEvent extends NationalIdEvent{
  NationalIdEntity nationalId;
  String token;

  GetNationalIdEvent({required this.nationalId, required this.token});

  @override
  List<Object> get props => [nationalId];
}

class DeleteNationalIdEvent extends NationalIdEvent{
  @override
  List<Object> get props => [];
}
