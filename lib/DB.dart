import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

import 'package:weatherly/models/City.dart';

class DB {
  static Database _db;

  Future<Database> get db async {
    if(_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    final database = openDatabase(join(await getDatabasesPath(), 'cities.db'),
        onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE cities (id INTEGER PRIMARY KEY, name TEXT)",
      );
    }, version: 1);
    return database;
  }

  Future<int> insertCity(City city) async {
    var dbClient = await db;

    return await dbClient.insert('cities', city.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<City>> listCities() async {
    var dbClient = await db;

    List<Map> maps = await dbClient.query('cities', orderBy: 'id DESC', columns: ['id', 'name']);
    List<City> cities = [];
    if (maps.length > 0) {
      for(int i = 0; i < maps.length; i++) {
        cities.add(City.fromMap(maps[i]));
      }
    }
    return cities;
  }

  Future<int> deleteCity(int id) async {
    var dbClient = await db;
    
    return await dbClient.delete(
      'cities',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAll() async {
    var dbClient = await db;

    return await dbClient.delete('cities');
  }
}
