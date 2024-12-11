import 'package:baseflutter/data/repositories/user_repository.dart';
import 'package:baseflutter/data/sources/local/dao/client/database.dart';
import 'package:baseflutter/data/sources/local/user_local_data_source.dart';
import 'package:baseflutter/data/sources/remote/user_remote_data_source.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

Future<void> setupRepositories(GetIt getIt) async {
  // Register Dio with the global interceptor
  final dio = Dio();

  //local
  // Register AppDatabase
  final appDatabase = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  getIt.registerLazySingleton(() => appDatabase);

  // Register Dio instance globally so it can be used by any data source
  getIt.registerLazySingleton<Dio>(() => dio);

  // Register remote data source
  getIt.registerLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSource(getIt()));

  // Register local data source
  getIt.registerLazySingleton<UserLocalDataSource>(() => UserLocalDataSourceImpl(database: getIt()));

  // Register repository
  getIt.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
        remoteDataSource: getIt(),
        localDataSource: getIt(),
      ));
}
