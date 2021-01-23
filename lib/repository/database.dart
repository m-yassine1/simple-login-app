import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:servme_login_app/model/user.dart';
import 'package:sqflite/sqflite.dart';

class AuthDatabase {
  Future<Database> getDatabaseConnection() async {
    WidgetsFlutterBinding.ensureInitialized();
    return openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
        join(await getDatabasesPath(), 'authentication_database.db'),
        onCreate: (db, version) {
          // Run the CREATE TABLE statement on the database.
          return db.execute(
            "CREATE TABLE auth(id INTEGER PRIMARY KEY, access_token TEXT, account_type_id INTEGER, total_active_sessions INTEGER, account_id INTEGER, ambassador_id INTEGER)",
          );
        },
        version: 2
    );
  }

  Future<void> insert(User user) async {
    final Database db = await getDatabaseConnection();
    await db.insert('auth', user.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    await close(db);
  }

  Future<void> delete() async {
    final Database db = await getDatabaseConnection();
    await db.delete('auth');
    await close(db);
  }

  Future<UserEntity> getUser() async {
    final Database db = await getDatabaseConnection();
    List<Map> maps = await db.query('auth');
    await close(db);
    if(maps.length > 0) {
      return UserEntity.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future close(Database db) async {
    await db.close();
  }
}