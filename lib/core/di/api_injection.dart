import 'package:baseflutter/core/utils/api_interceptor.dart';
import 'package:baseflutter/data/sources/local/dao/client/database.dart';
import 'package:baseflutter/data/sources/remote/client/api_client.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Future<void> setupApi(GetIt getIt) async {
  getIt.registerLazySingleton<Dio>(() {
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
  getIt.registerLazySingleton<ApiClient>(() => ApiClient(getIt<Dio>()));

  // Register AppDatabase
  final appDatabase = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  getIt.registerLazySingleton(() => appDatabase);
}
