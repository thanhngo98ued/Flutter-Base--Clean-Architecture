import 'package:baseflutter/data/models/user_model.dart';
import 'package:baseflutter/data/sources/local/dao/client/database.dart';

class UserLocalDataSource {
  final AppDatabase database;

  UserLocalDataSource({required this.database});

  Future<List<UserModel>?> getUsers() async {
    return await database.userDao.getAllUsers();
  }

  Future<void> saveUsers(List<UserModel> users) async {
    await database.userDao.insertUsers(users);
  }
}
