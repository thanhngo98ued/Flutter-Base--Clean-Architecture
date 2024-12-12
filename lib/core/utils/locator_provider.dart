// lib/core/utils/locator_provider.dart
import 'package:baseflutter/core/di/di.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Generic provider to fetch dependencies from GetIt
Provider<T> locatorProvider<T extends Object>() {
  return Provider<T>((ref) => locator<T>());
}
