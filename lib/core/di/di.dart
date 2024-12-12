// lib/core/di.dart
import 'package:baseflutter/core/utils/api_interceptor.dart';
import 'package:baseflutter/data/repositories/impl/user_repository_impl.dart';
import 'package:baseflutter/data/repositories/user_repository.dart';
import 'package:baseflutter/data/sources/local/dao/client/database.dart';
import 'package:baseflutter/data/sources/remote/client/api_client.dart';
import 'package:baseflutter/data/sources/remote/user_remote_data_source.dart';
import 'package:baseflutter/domain/mapper/user_mapper.dart';
import 'package:baseflutter/domain/usercases/get_users_usecase.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../data/sources/local/user_local_data_source.dart';

final locator = GetIt.instance;
Future<void> setupDependenceInjection() async {
  // Register Dio with the global interceptor
  locator.registerLazySingleton<Dio>(() {
    final dio = Dio(BaseOptions(
      baseUrl: "https://jsonplaceholder.typicode.com/", // Replace with your base URL
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));

    dio.interceptors.add(ApiInterceptor());
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        filter: (options, args) {
          //  return !options.uri.path.contains('posts');
          return !args.isResponse || !args.hasUint8ListData;
        },
      ),
    );
    return dio;
  });

  // Register ApiClient
  locator.registerLazySingleton<ApiClient>(() => ApiClient(locator<Dio>()));

  // Register data source
  locator.registerLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSource(apiClient: locator()));
  locator.registerLazySingleton<UserLocalDataSource>(() => UserLocalDataSource(database: locator()));

  // Register repository impl
  locator.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
        remoteDataSource: locator(),
        localDataSource: locator(),
      ));

  // Register AppDatabase
  final appDatabase = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  locator.registerLazySingleton(() => appDatabase);

  locator.registerLazySingleton<GetUsersUseCase>(() => GetUsersUseCase(locator()));
  locator.registerLazySingleton<UserMapper>(() => UserMapper());
}
