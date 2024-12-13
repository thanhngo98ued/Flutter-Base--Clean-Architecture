import 'package:baseflutter/data/repositories/impl/user_repository_impl.dart';
import 'package:baseflutter/data/repositories/user_repository.dart';
import 'package:baseflutter/data/sources/local/user_local_data_source.dart';
import 'package:baseflutter/data/sources/remote/user_remote_data_source.dart';
import 'package:get_it/get_it.dart';

void setupRepositories(GetIt getIt) {
  // Register data source
  getIt.registerLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSource(apiClient: getIt()));
  getIt.registerLazySingleton<UserLocalDataSource>(() => UserLocalDataSource(database: getIt()));

  // Register repository impl
  getIt.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
        remoteDataSource: getIt(),
        localDataSource: getIt(),
      ));
}
