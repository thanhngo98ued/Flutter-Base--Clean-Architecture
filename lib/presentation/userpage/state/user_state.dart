// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:collection/collection.dart';

import 'package:baseflutter/domain/entities/user_entity.dart';

class UserState {
  final List<UserEntity>? users;

  UserState({
    this.users,
  });

  UserState copyWith({
    List<UserEntity>? users,
  }) {
    return UserState(
      users: users ?? this.users,
    );
  }

  @override
  String toString() => 'UserState(users: $users)';

  @override
  bool operator ==(covariant UserState other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return listEquals(other.users, users);
  }

  @override
  int get hashCode => users.hashCode;
}
