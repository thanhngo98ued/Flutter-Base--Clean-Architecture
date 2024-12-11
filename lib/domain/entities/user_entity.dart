// lib/domain/entities/user_entity.dart
import 'package:baseflutter/domain/entities/base_entity.dart';

class UserEntity extends BaseEntity {
  final int id;
  final String name;
  final String email;

  UserEntity({required this.id, required this.name, required this.email});
}
