import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection {
  Future<Database> setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_crud');
    var database =
        await openDatabase(path, version: 1, onCreate: _createDatabase);
    return database;
  }

  Future<Database> setCategoryDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_crud');
    var database =
        await openDatabase(path, version: 1, onCreate: _createCategory);
    return database;
  }

  Future<void> _createDatabase(Database database, int version) async {
    String sql =
        "CREATE TABLE mydb(id INTEGER PRIMARY KEY AUTOINCREMENT, type TEXT NOT NULL , desc TEXT NOT NULL, price REAL NOT NULL, datatime TEXT NOT NULL, isincome INTEGER NOT NULL)";
    await database.execute(sql);
  }

  Future<void> _createCategory(Database database, int version) async {
    String sql =
        "CREATE TABLE mycategory(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL , desc TEXT NOT NULL, datatime TEXT NOT NULL,)";
    await database.execute(sql);
  }
}
