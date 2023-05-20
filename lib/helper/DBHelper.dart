
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:khoaluan/model/dictionary_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper{
  DBHelper._();
  static final DBHelper db = DBHelper._();

  static Database? _database = null;
  Future<Database?> get database async{
    if(_database!= null)
      return _database;
    _database = await initDB();
    return _database;
  }


  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "assets/dict_hh.db");
    final exist = await databaseExists(path);
    if(!exist){
      try{
        await Directory(dirname(path)).create(recursive: true);
      }catch(_) {}
      ByteData data = await rootBundle.load(join("assets","dict_hh.db"));
      List<int> bytes =  await data.buffer.asUint8List(data.offsetInBytes,data.lengthInBytes);
      await File(path).writeAsBytes(bytes,flush: true);

      print("Coppy database");
    }
    return await openDatabase(path);
  }

  Future<List<DictionaryModel>> getListDictionary() async{
    final db = await database;
    var res = await db!.query("av");
    print(res.length);
    return res!.isNotEmpty ? res.map((c) => DictionaryModel.fromMap(c)).toList() : [];
  }
}