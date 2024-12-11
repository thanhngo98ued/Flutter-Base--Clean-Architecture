import 'package:baseflutter/data/models/user_model.dart';
import 'package:baseflutter/data/sources/local/dao/client/database.dart';

abstract class UserLocalDataSource {
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser(int id);
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final AppDatabase database;

  UserLocalDataSourceImpl({required this.database});

  @override
  Future<UserModel?> getUser(int id) async {
    return await database.userDao.getUserById(id);
  }

  @override
  Future<void> saveUser(UserModel user) async {
    await database.userDao.insertUser(user);
  }
}
