import 'package:sqflite/sqflite.dart';
import 'package:wallefy/data/data_providers/database_connection.dart';

class Repository {
  late DatabaseConnection _databaseConnection;
  Repository() {
    _databaseConnection = DatabaseConnection();
  }
  static Database? _database, _categorydatabase;
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _databaseConnection.setDatabase();
      return _database;
    }
  }

  Future<Database?> get categorydatabase async {
    if (_categorydatabase != null) {
      return _categorydatabase;
    } else {
      _categorydatabase = await _databaseConnection.setCategoryDatabase();
      return _categorydatabase;
    }
  }

  //Insert User
  insertData(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  //Insert Category
  indertCategory(table, data) async {
    var connection = await categorydatabase;
    return await connection?.insert(table, data);
  }

  //Read All Record
  readData(table) async {
    var connection = await database;
    return await connection?.query(table);
  }

  // Read All Category
  readCategory(table) async {
    var connection = await categorydatabase;
    return await connection?.query(table);
  }

  //Read a Single Record By ID
  readDataById(table, itemId) async {
    var connection = await database;
    return await connection?.query(table, where: 'id=?', whereArgs: [itemId]);
  }

  //Read a Single Record Cateogry By ID
  readCateogryById(table, itemId) async {
    var connection = await categorydatabase;
    return await connection?.query(table, where: 'id=?', whereArgs: [itemId]);
  }

  //Update User
  updateData(table, data) async {
    var connection = await database;
    return await connection
        ?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  //Update User
  updateCategoryData(table, data) async {
    var connection = await categorydatabase;
    return await connection
        ?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  //Delete User
  deleteDataById(table, itemId) async {
    var connection = await database;
    return await connection?.rawDelete("delete from $table where id=$itemId");
  }

  //Delete Category
  deleteCategoryById(table, itemId) async {
    var connection = await categorydatabase;
    return await connection?.rawDelete("delete from $table where id=$itemId");
  }
}
