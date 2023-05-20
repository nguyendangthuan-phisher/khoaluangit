import 'package:flutter/material.dart';
import 'package:khoaluan/about_us.dart';
import 'package:khoaluan/dictionary_detail.dart';
import 'package:khoaluan/dictionary_page.dart';
import 'package:khoaluan/helper/DBHelper.dart';
import 'package:khoaluan/history_page.dart';
import 'package:khoaluan/homepage.dart';
import 'package:khoaluan/model/dictionary_model.dart';
import 'package:khoaluan/provider/product_provider.dart';
import 'package:khoaluan/speechpage.dart';
import 'package:khoaluan/translate_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List<DictionaryModel> node =  await DBHelper.db.getListDictionary();
  // for(DictionaryModel a in node){
  //    print ("[");
  //    print(a.word );
  //   print(a.category);
  //   print(a.pronounce);
  //   print(a.html);
  //   print(a.description);
  //   print("]");
  //
  // }
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_)=> ProductProvider())
    ],
    child: MaterialApp(
      home: HomePage(),
    ),
  ));
}




// void main() {
//   runApp(MaterialApp(
//       home: HomePage()
//   ));
// }
