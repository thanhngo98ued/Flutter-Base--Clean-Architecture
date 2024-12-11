// ignore_for_file: public_member_api_docs, sort_constructors_first
// lib/presentation/viewmodels/user_viewmodel.dart
import 'package:baseflutter/domain/usercases/get_users_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_viewmodel.g.dart';

@riverpod
class UserViewModel extends _$UserViewModel {
  late final GetUsersUseCase getUsersUseCase;

  @override
  Future<void> build() async {
    await getUsersUseCase();
  }
}
