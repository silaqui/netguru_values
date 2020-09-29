import 'package:get_it/get_it.dart';
import 'package:netguru_values/features/netguru_values/data/datasource/netguru_values_local_datasource.dart';
import 'package:netguru_values/features/netguru_values/data/datasource/persistent_data_source.dart';
import 'package:netguru_values/features/netguru_values/data/repository/netguru_values_repository_impl.dart';
import 'package:netguru_values/features/netguru_values/presentation/bloc/add_value/add_value_bloc.dart';

import 'features/netguru_values/domain/repositories/netguru_values_repository.dart';
import 'features/netguru_values/domain/usecases/get_all_netguru_value.dart';
import 'features/netguru_values/domain/usecases/get_random_favorite_netguru_value.dart';
import 'features/netguru_values/domain/usecases/get_random_netguru_value.dart';
import 'features/netguru_values/domain/usecases/put_netguru_value.dart';
import 'features/netguru_values/domain/usecases/toggle_favorite_netguru_value.dart';
import 'features/netguru_values/presentation/bloc/netguru_values/netguru_values_bloc.dart';
import 'features/netguru_values/presentation/bloc/netguru_values_list/netguru_values_list_bloc.dart';

final GetIt getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerFactory(() => NetguruValuesBloc(getIt(), getIt()));
  getIt.registerFactory(() => NetguruValuesListBloc(getIt()));
  getIt.registerFactory(() => AddValueBloc(getIt()));

  getIt.registerLazySingleton(() => GetAllNetguruValue(getIt()));
  getIt.registerLazySingleton(() => GetRandomNetguruValue(getIt()));
  getIt.registerLazySingleton(() => GetRandomFavoriteNetguruValue(getIt()));
  getIt.registerLazySingleton(() => PutNetguruValue(getIt()));
  getIt.registerLazySingleton(() => ToggleFavoriteNetguruValue(getIt()));

  getIt.registerLazySingleton<NetguruValuesRepository>(
      () => NetguruValuesRepositoryImpl(getIt()));

  getIt.registerSingleton<NetguruValuesLocalDataSource>(
      PersistentDataSource.instance);
}
