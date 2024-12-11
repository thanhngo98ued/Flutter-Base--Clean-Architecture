// ignore_for_file: public_member_api_docs, sort_constructors_first
// lib/presentation/viewmodels/user_viewmodel.dart
import 'package:baseflutter/core/utils/locator_provider.dart';
import 'package:baseflutter/domain/mapper/user_mapper.dart';
import 'package:baseflutter/domain/usercases/get_users_usecase.dart';
import 'package:baseflutter/presentation/viewmodels/state/user_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_viewmodel.g.dart';

@riverpod
class UserViewModel extends _$UserViewModel {
  late final GetUsersUseCase getUsersUseCase;
  late final UserMapper userMapper;
  @override
  Future<UserState> build() async {
    getUsersUseCase = ref.watch(locatorProvider<GetUsersUseCase>());
    userMapper = ref.watch(locatorProvider<UserMapper>());
    return UserState();
  }

  Future<void> getUsers() async {
    try {
      final users = await getUsersUseCase.getUsers() ?? [];
      state = AsyncData(state.requireValue.copyWith(users: userMapper.mapCollection(users)));
    } catch (error) {
      print("Error ${error.hashCode}");
    }
  }
}
