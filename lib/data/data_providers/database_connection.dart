import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wallefy/data/models/category_model.dart';

class DatabaseConnection {
  Database? database;

  final String databaseName = 'sqlite.db';
  final int databaseVersion = 1;

  Future<void> init() async {
    var databasesPath = await getApplicationDocumentsDirectory();
    var path = join(databasesPath.path, databaseName);

    // Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets/db", databaseName));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    }
    database = await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<Database> setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, databaseName);
    var database =
        await openDatabase(path, version: 1, onCreate: _createDatabase);
    return database;
  }

  Future<Database> setCategoryDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, databaseName);
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
        "CREATE TABLE myctg(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL , datatime TEXT NOT NULL,)";
    await database.execute(sql);
  }
}
