// lib/data/sources/local/database.dart
import 'dart:async';
import 'package:baseflutter/data/models/user_model.dart';
import 'package:floor/floor.dart';
import '../user_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [UserModel])
abstract class AppDatabase extends FloorDatabase {
  UserDao get userDao;
}
