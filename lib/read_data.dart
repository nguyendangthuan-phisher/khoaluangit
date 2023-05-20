import 'package:flutter/material.dart';
import 'package:khoaluan/model/dictionary_model.dart';
import 'package:sqflite/sqflite.dart';

import 'model/moor.dart';

class ReadData extends StatelessWidget {
  const ReadData({Key? key}) : super(key: key);
  Future<void> myFunction() async {
    final List<DictionaryModel> words = await DictionaryDatabase.getWords();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
