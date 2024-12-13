// lib/data/repositories/user_repository_impl.dart
import 'package:baseflutter/data/models/user_model.dart';
import 'package:baseflutter/data/repositories/user_repository.dart';
import 'package:baseflutter/data/sources/local/user_local_data_source.dart';
import 'package:baseflutter/data/sources/remote/user_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<UserModel>?> getUsers() async {
    final localUsers = await localDataSource.getUsers();
    if (localUsers?.isNotEmpty == true) {
      return localUsers;
    }

    // Fetch from remote if local data is not available
    final users = await remoteDataSource.getUsers();
    localDataSource.saveUsers(users ?? []); // Save to local storage
    return users;
  }
}
