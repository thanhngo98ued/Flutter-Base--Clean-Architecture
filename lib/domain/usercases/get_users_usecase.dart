// lib/domain/usecases/get_users_usecase.dart
import 'package:baseflutter/data/models/user_model.dart';
import 'package:baseflutter/data/repositories/user_repository.dart';

class GetUsersUseCase {
  final UserRepository repository;

  GetUsersUseCase(this.repository);

  Future<List<UserModel>?> getUsers() => repository.getUsers();
}
