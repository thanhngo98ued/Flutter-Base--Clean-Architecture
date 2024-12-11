// lib/data/sources/local/dao/user_dao.dart
import 'package:floor/floor.dart';
import '../../../models/user_model.dart';

@dao
abstract class UserDao {
  @Query('SELECT * FROM UserModel')
  Future<List<UserModel>> getAllUsers();

  @Query('SELECT * FROM UserModel WHERE id = :id')
  Future<UserModel?> getUserById(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertUser(UserModel user);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertUsers(List<UserModel> users);

  @delete
  Future<void> deleteUser(UserModel user);

  @Query('DELETE FROM UserModel')
  Future<void> clearUsers();
}
