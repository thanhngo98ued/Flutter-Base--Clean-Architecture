// lib/core/di.dart
import 'package:baseflutter/core/di/api_injection.dart';
import 'package:baseflutter/core/di/mapper_injection.dart';
import 'package:baseflutter/core/di/repository_injection.dart';
import 'package:baseflutter/core/di/use_case_injection.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;
Future<void> setupDependenceInjection() async {
  await setupApi(locator);
  setupRepositories(locator);
  setupUseCase(locator);
  setupMapper(locator);
}
