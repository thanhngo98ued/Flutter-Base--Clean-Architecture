// lib/presentation/views/user_view.dart
import 'package:baseflutter/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../user_viewmodel.dart';

class UserPage extends ConsumerStatefulWidget {
  const UserPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserViewState();
}

class _UserViewState extends ConsumerState<UserPage> {
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
      body: Column(
        children: [
          SizedBox(
            height: 80.h,
          ),
          _buildHeader(),
          SizedBox(
            height: 40.h,
          ),
          _buildUsers(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Text(
      "Demo flutter base",
      style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.black),
    );
  }

  Widget _buildUsers() {
    final users = ref.watch(userViewModelProvider.select((value) => value.valueOrNull?.users ?? []));
    return Expanded(
      child: ListView.builder(
        itemCount: users.length,
        padding: EdgeInsets.all(20.w),
        itemBuilder: (context, index) {
          return _buildUser(users[index]);
        },
      ),
    );
  }

  Widget _buildUser(UserEntity user) {
    return Row(
      children: [
        Text(user.id.toString()),
        SizedBox(width: 4.w),
        Text(user.name),
        SizedBox(width: 4.w),
        Text(user.email),
      ],
    );
  }
}
