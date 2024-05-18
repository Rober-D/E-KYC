// Here We use get_it package.
// It is a design patterns to use to make the code clean and faster.
import 'package:e_kyc/features/auth/data/datasources/authetication_remote_data_source.dart';
import 'package:e_kyc/features/auth/data/repositories/AuthenticationRepositoryImpl.dart';
import 'package:e_kyc/features/auth/domain/repositories/AuthenticationRepository.dart';
import 'package:e_kyc/features/auth/domain/usecases/get_user_usecase.dart';
import 'package:e_kyc/features/auth/domain/usecases/login_usecase.dart';
import 'package:e_kyc/features/auth/domain/usecases/register_usecase.dart';
import 'package:e_kyc/features/national_id/data/datasources/national_id_remote_date_source.dart';
import 'package:e_kyc/features/national_id/data/repositories/national_id_repository_impl.dart';
import 'package:e_kyc/features/national_id/domain/repositories/national_id_repository.dart';
import 'package:e_kyc/features/national_id/domain/usecases/create_national_id_usecase.dart';
import 'package:e_kyc/features/national_id/domain/usecases/delete_national_id_usecase.dart';
import 'package:e_kyc/features/national_id/domain/usecases/get_national_id_usecase.dart';
import 'package:e_kyc/features/national_id/domain/usecases/get_server_link_usecase.dart';
import 'package:e_kyc/features/national_id/domain/usecases/update_national_id_usecase.dart';
import 'package:e_kyc/features/national_id/presentation/bloc/national_id_bloc.dart';
import 'package:e_kyc/features/national_id/presentation/server_bloc/server_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/network/network_info.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  // Features

  // Bloc - Factory.
  // one line for each bloc.
  sl.registerFactory(() => AuthBloc(
      loginUseCase: sl(), registerUseCase: sl(), getUserUseCase: sl()));
  sl.registerFactory(() => NationalIdBloc(
      createNationalIdUseCase: sl(),
      deleteNationalIdUseCase: sl(),
      getNationalIdUseCase: sl(),
      updateNationalIdUseCase: sl()));
  sl.registerFactory(() => ServerBloc(getServerLinkUseCase: sl()));

  // Usecases - Lazy Singleton.
  sl.registerLazySingleton(
      () => RegisterUseCase(authenticationRepository: sl()));
  sl.registerLazySingleton(() => LoginUseCase(authenticationRepository: sl()));
  sl.registerLazySingleton(
      () => GetUserUseCase(authenticationRepository: sl()));
  sl.registerLazySingleton(
      () => CreateNationalIdUseCase(nationalIdRepository: sl()));
  sl.registerLazySingleton(
      () => GetNationalIdUseCase(nationalIdRepository: sl()));
  sl.registerLazySingleton(
      () => UpdateNationalIdUseCase(nationalIdRepository: sl()));
  sl.registerLazySingleton(
      () => DeleteNationalIdUseCase(nationalIdRepository: sl()));
  sl.registerLazySingleton(
      () => GetServerLinkUseCase(nationalIdRepository: sl()));

  // Repository - Lazy Singleton.
  sl.registerLazySingleton<AuthenticationRepository>(() =>
      AuthenticationRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<NationalIdRepository>(() => NationalIdRepositoryImpl(
      networkInfo: sl(), nationalIdRemoteDataSource: sl()));

  // Datasources
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthRemoteDataSourceDio());
  sl.registerLazySingleton<NationalIdRemoteDataSource>(
      () => NationalIdRemoteDataSourceDio());

  // Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  //we can add here another one for internet connection & APIs.
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
