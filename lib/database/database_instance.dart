import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:takehomechallenge/model/model_get_fav.dart';

class DatabaseInstance {
  final String _databaseName = 'my_database.db';
  final int _databaseVersion = 1;

  final String table = 'character';
  final String id = 'id';
  final String name = 'name';
  final String species = 'species';
  final String gender = 'gender';
  final String origin = 'origin';
  final String location = 'location';
  final String image = 'image';

  Database? _database;

  Future<Database> database() async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    print("succes");
    return _database!;
  }

  Future _initDatabase() async {
    Directory documentDir = await getApplicationDocumentsDirectory();
    String path = join(documentDir.path, _databaseName);
    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $table ($id INTEGER PRIMARY KEY, $name TEXT, $species TEXT, $gender TEXT, $origin TEXT, $location TEXT, $image TEXT)');
  }

  Future<List<Datum>> all() async {
    Database? db = await _database!;
    final data = await db!.query(table);
    print('proses');
    List<Datum> result = data.map((e) => Datum.fromJson(e)).toList();
    print(result);
    return result;
  }

  Future<int> insert(Map<String, dynamic> row) async {
    final query = _database!.insert(table, row);
    print(query);
    return query;
  }

  Future delete(int idParam) async {
    Database? db = await _database!;
    await db.delete(table, where: '$id = ?', whereArgs: [idParam]);
  }
}
