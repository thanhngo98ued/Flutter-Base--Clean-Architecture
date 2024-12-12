import 'package:baseflutter/data/models/user_model.dart';
import 'package:baseflutter/domain/entities/user_entity.dart';
import 'package:baseflutter/domain/mapper/base_mapper.dart';

class UserMapper extends BaseMapper<UserModel, UserEntity> {
  @override
  UserEntity map(UserModel data) {
    return UserEntity(
      id: data.id,
      name: data.name,
      email: data.email,
    );
  }
}
