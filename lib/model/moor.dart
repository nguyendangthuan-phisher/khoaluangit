import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'dictionary_model.dart';

class DictionaryDatabase {
  static late Database _database;

  static Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await _initDatabase();
    return _database;
  }

  static Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'dict_hh.db');

    return openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  static void _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE dictionary(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        word TEXT,
        html TEXT,
        description TEXT,
        pronounce TEXT
      );
    ''');
  }

  static Future<List<DictionaryModel>> getWords() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('dictionary');

    return List.generate(maps.length, (i) {
      return DictionaryModel(
        id: maps[i]['id'],
        word: maps[i]['word'],
        html: maps[i]['html'],
        description: maps[i]['description'],
        pronounce: maps[i]['pronounce'],
      );
    });
  }
}
