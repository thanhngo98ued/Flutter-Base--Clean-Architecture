// lib/core/di.dart
import 'package:baseflutter/core/di/repository_module.dart';
import 'package:baseflutter/core/di/use_case_module.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;
void setup() {
  setupRepositories(locator);
  setupUseCases(locator);
}
