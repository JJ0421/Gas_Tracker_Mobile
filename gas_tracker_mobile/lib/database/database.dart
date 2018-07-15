import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:async';
import 'dart:io';

class VehicleDatabase {
  static final VehicleDatabase _instance = VehicleDatabase._internal();

  factory VehicleDatabase() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  VehicleDatabase._internal();

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE Vehicles(id STRING PRIMARY KEY, year TEXT, make TEXT, model TEXT, mpg INT, miles INT)");
    print("Database was Created");
  }

  Future<int> addVehicle(
      String data_key, String year, String make, String model, int mpg) async {
    var dbClient = await db;
    Map<String, dynamic> dataMap = new Map<String, dynamic>();
    dataMap['id'] = data_key;
    dataMap['year'] = year;
    dataMap['make'] = make;
    dataMap['model'] = model;
    dataMap['mpg'] = mpg;
    dataMap['miles'] = 0;
    int res = await dbClient.insert("Vehicles", dataMap);
    print("Vehicle added $res");
    return res;
  }

  Future<List<Map<String, dynamic>>> selectAll() async {
    List<Map<String, dynamic>> map = new List<Map<String, dynamic>>();
    var dbClient = await db;
    map = await dbClient.query("Vehicles");
    return map;
  }

  Future<int> deleteVehicle(String id) async {
    var dbClient = await db;
    int res = await dbClient.delete("Vehicles", where: "id = ?", whereArgs: [id]);
    print(res);
    return res;
  }

  Future closeDb() async {
    var dbClient = await db;
    dbClient.close();
  }
}
