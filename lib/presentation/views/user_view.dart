// lib/presentation/views/user_view.dart
import 'package:baseflutter/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodels/user_viewmodel.dart';

class UserView extends ConsumerStatefulWidget {
  const UserView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserViewPage();
}

class _UserViewPage extends ConsumerState<UserView> {
  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() {
    ref.read(userViewModelProvider.notifier).getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _buildUsers(),
      ),
    );
  }

  Widget _buildUsers() {
    final users = ref.watch(userViewModelProvider.select((value) => value.valueOrNull?.users ?? []));
    print("abcc ${users.length}");
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return _buildUser(users[index]);
      },
    );
  }

  Widget _buildUser(UserEntity user) {
    return Row(
      children: [
        const Text("12333"),
        Text(user.name),
        Text(user.email),
      ],
    );
  }
}
