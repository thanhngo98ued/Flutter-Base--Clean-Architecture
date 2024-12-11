import 'package:baseflutter/data/models/user_model.dart';

abstract class UserRepository {
  Future<List<UserModel>?> getUsers();
}
