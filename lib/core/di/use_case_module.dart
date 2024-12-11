import 'package:baseflutter/data/repositories/user_repository.dart';
import 'package:baseflutter/domain/usercases/get_users_usecase.dart';
import 'package:get_it/get_it.dart';

void setupUseCases(GetIt getIt) {
  // Register GetUsersUseCase with UserApi
  getIt.registerLazySingleton<GetUsersUseCase>(() => GetUsersUseCase(getIt<UserRepository>()));
}
