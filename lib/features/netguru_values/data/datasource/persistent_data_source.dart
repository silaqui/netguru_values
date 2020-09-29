import 'dart:math';

import 'package:netguru_values/core/error/exceptions.dart';
import 'package:netguru_values/features/netguru_values/data/datasource/core_values.dart';
import 'package:netguru_values/features/netguru_values/data/datasource/netguru_values_local_datasource.dart';
import 'package:netguru_values/features/netguru_values/data/models/netguru_value_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PersistentDataSource implements NetguruValuesLocalDataSource {
  static const String _databaseName = "netguru_values_database.db";
  static const int _databaseVersion = 1;

  static const String tableValues = 'netguru';
  static const String columnId = 'id';
  static const String columnText = 'valueText';
  static const String columnFavorite = 'isFavorite';
  static const String columnDefault = 'isDefault';

  Random rng = Random();

  PersistentDataSource._privateConstructor();

  static final PersistentDataSource instance =
      PersistentDataSource._privateConstructor();

  Database _database;

  Future<Database> get database async {
    // ignore: join_return_with_assignment
    _database ??= await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), _databaseName);
    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableValues (
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnText TEXT DEFAULT '',
          $columnFavorite INTEGER DEFAULT 0,
          $columnDefault INTEGER DEFAULT 0
          )
          ''');

    for (final NetguruValueModel v in coreValues.values) {
      db.insert(tableValues, v.toMap());
    }
  }

  @override
  Future<List<NetguruValueModel>> getAll() async {
    final Database db = await instance.database;
    final List<Map> maps = await db.query(tableValues);
    return List.generate(maps.length, (i) {
      return NetguruValueModel.fromMap(maps[i]);
    });
  }

  @override
  Future<NetguruValueModel> getRandom() async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableValues);
    if (maps.isEmpty) {
      throw MemoryException();
    }
    final int i = rng.nextInt(maps.length);
    return NetguruValueModel.fromMap(maps[i]);
  }

  @override
  Future<NetguruValueModel> getRandomFavorite() async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> maps =
    await db.query(tableValues, where: "isFavorite = 1");
    if (maps.isEmpty) {
      throw MemoryException();
    }
    final int i = rng.nextInt(maps.length);
    return NetguruValueModel.fromMap(maps[i]);
  }

  @override
  Future<NetguruValueModel> put(NetguruValueModel value) async {
    final Database db = await instance.database;
    final int id = await db.insert(tableValues, value.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return NetguruValueModel(id: id,
        text: value.text,
        isFavorite: value.isFavorite,
        isDefault: value.isDefault);
  }
}
