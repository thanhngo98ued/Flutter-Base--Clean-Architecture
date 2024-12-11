import 'package:baseflutter/data/models/user_model.dart';
import 'package:baseflutter/data/sources/local/dao/client/database.dart';

class UserLocalDataSource {
  final AppDatabase database;

  UserLocalDataSource({required this.database});

  Future<UserModel?> getUser(int id) async {
    return await database.userDao.getUserById(id);
  }

  Future<void> saveUser(UserModel user) async {
    await database.userDao.insertUser(user);
  }
}
