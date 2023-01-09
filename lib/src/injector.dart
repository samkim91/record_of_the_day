import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:way_to_fit/src/data/repositories/auth_repository_impl.dart';
import 'package:way_to_fit/src/data/repositories/wod_repository_impl.dart';
import 'package:way_to_fit/src/domain/repositories/auth_repository.dart';
import 'package:way_to_fit/src/domain/repositories/wod_repository.dart';
import 'package:way_to_fit/src/presentation/blocs/auth/auth_bloc.dart';
import 'package:way_to_fit/src/presentation/blocs/navigation/navigation_cubit.dart';
import 'package:way_to_fit/src/presentation/blocs/wod/create/wod_create_bloc.dart';
import 'package:way_to_fit/src/presentation/blocs/wod/list/wod_list_bloc.dart';
import 'package:way_to_fit/src/presentation/blocs/wod/read/wod_read_bloc.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio
  injector.registerSingleton<Dio>(Dio());

  // Services

  // Repositories
  injector.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  injector.registerSingleton<WodRepository>(WodRepositoryImpl());

  // Blocs
  injector.registerFactory<AuthBloc>(() => AuthBloc(injector()));
  injector.registerFactory<WodCreateBloc>(() => WodCreateBloc(injector()));
  injector.registerFactory<WodReadBloc>(() => WodReadBloc(injector()));
  injector.registerFactory<WodListBloc>(() => WodListBloc(injector()));

  // Presentation
  injector.registerSingleton<NavigationCubit>(NavigationCubit());
}
