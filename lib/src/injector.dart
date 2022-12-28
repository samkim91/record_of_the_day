import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:way_to_fit/src/data/repositories/auth_repository_impl.dart';
import 'package:way_to_fit/src/domain/repositories/auth_repository.dart';
import 'package:way_to_fit/src/presentation/blocs/auth/auth_bloc.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio
  injector.registerSingleton<Dio>(Dio());

  // Services

  // Repositories
  injector.registerSingleton<AuthRepository>(AuthRepositoryImpl());


  // Blocs
  injector.registerFactory<AuthBloc>(() => AuthBloc(injector()));
}
