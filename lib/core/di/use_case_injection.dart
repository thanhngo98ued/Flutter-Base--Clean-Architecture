import 'package:baseflutter/domain/usercases/get_users_usecase.dart';
import 'package:get_it/get_it.dart';

void setupUseCase(GetIt getIt) {
  getIt.registerLazySingleton<GetUsersUseCase>(() => GetUsersUseCase(getIt()));
}
