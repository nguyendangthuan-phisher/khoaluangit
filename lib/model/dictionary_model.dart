import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';



class DictionaryModel {
  int? id;
  String? word;
  String? html;
  String? description;
  String? pronounce;
  String? category;

  DictionaryModel({
    this.id,
    this.word,
    this.html,
    this.description,
    this.pronounce,
  });

  Map<String, dynamic> toMap() => {'id': id, 'word': word, 'html': html, 'description': description, 'pronounce': pronounce};

  factory DictionaryModel.fromMap(Map<String, dynamic> map) {
    return DictionaryModel(id: map['id'], word: map['word'], html: map['html'], description: map['description'], pronounce: map['pronounce']);
  }

}