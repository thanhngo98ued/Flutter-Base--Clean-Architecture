// lib/data/repositories/user_repository_impl.dart
import 'package:baseflutter/data/models/user_model.dart';
import 'package:baseflutter/data/sources/local/user_local_data_source.dart';
import 'package:baseflutter/data/sources/remote/user_remote_data_source.dart';

abstract class UserRepository {
  Future<UserModel> getUser();
}

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<UserModel> getUser() async {
    // Try to fetch from local storage first
    final localUser = await localDataSource.getUser(1);
    if (localUser != null) {
      return localUser;
    }

    // Fetch from remote if local data is not available
    final remoteUser = await remoteDataSource.getUser();
    localDataSource.saveUser(remoteUser); // Save to local storage
    return remoteUser;
  }
}
