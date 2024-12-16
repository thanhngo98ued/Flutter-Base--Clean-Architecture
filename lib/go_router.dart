import 'package:baseflutter/presentation/userpage/view/user_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const UserPage();
      },
      routes: const <RouteBase>[],
    ),
  ],
);
