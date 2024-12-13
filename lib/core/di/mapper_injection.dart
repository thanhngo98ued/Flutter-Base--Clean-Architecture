import 'package:baseflutter/domain/mapper/user_mapper.dart';
import 'package:get_it/get_it.dart';

void setupMapper(GetIt getIt) {
  getIt.registerLazySingleton<UserMapper>(() => UserMapper());
}
