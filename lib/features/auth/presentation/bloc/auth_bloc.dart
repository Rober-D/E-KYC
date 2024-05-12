import 'package:bloc/bloc.dart';
import 'package:e_kyc/core/error/failres.dart';
import 'package:e_kyc/core/strings/failures_msg.dart';
import 'package:e_kyc/features/auth/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;

  AuthBloc({required this.registerUseCase, required this.loginUseCase}) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async{
      if (event is RegisterEvent){
        emit(LoadingState());
        final register = await registerUseCase();
        register.fold((failure) => {
          emit(ErrorState(errorMsg: getFailureMsg(failure)))
        }, (success) => {
          emit(LoadedState())
        });
      }else if(event is LoginEvent){
        emit(LoadingState());
        final login = await loginUseCase(emailOrUsername:event.emailOrUserName ,password: event.password);
        login.fold((failure) => {
          emit(ErrorState(errorMsg: getFailureMsg(failure)))
        }, (success) => {
          emit(LoadedState())
        });
      }
    });
  }

  String getFailureMsg(Failures failure){
    switch(failure.runtimeType){
      case ServerFailure:
        return SERVER_FAILURE_MSG;
      case NetworkFailure:
        return NETWORK_FAILURE_MSG;
      case APIFailure:
        return API_FAILURE_MSG;

      default:
        return "Unexpected Error, Please try again later.";
    }
  }
}
