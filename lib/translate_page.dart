import 'dart:convert';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:khoaluan/dictionary_page.dart';
import 'package:khoaluan/provider/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart';
import 'package:translator/translator.dart';

import 'homepage.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/product_model.dart';
import 'navigation.dart';

class TranslatePage extends StatefulWidget {
  const TranslatePage({Key? key}) : super(key: key);

  @override
  State<TranslatePage> createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage> {
  String translated = 'Translation';
  Color clr = Color.fromRGBO(4, 44, 88, 1);
  TextEditingController textEditingController = TextEditingController();
  FlutterTts flutterTts = FlutterTts();
  void textToSpeech(String text) async
  {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setVolume(0.7);
    await flutterTts.setSpeechRate(0.8);
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  var speechControler = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var pp = Provider.of<ProductProvider>(context);
    if(pp.list.length==0)
      pp.getList();
    return Scaffold(
      drawer: Navigation(),
      appBar: AppBar(
        backgroundColor: clr,
        centerTitle: true,
        title:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 2),
                  child: Icon(Icons.menu_book),
                ),
                TextButton(
                    onPressed: (){
                      setState(() {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomePage()));
                      });
                    },
                    child: Text("[KLTN]  Dịch văn bản", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),)
                ),
              ],
            ),

          ],
        ),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),

      ),
      body: Card(
        margin: EdgeInsets.all(12.0),
        child: ListView(
          padding: EdgeInsets.all(12.0),
          children: [
            Text("English (US)"),
            SizedBox(height: 8,),
            TextField(
              maxLines: 5,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                hintText: 'Enter text',
              ),
              onChanged: (text) async{
                const apiKey = 'AIzaSyD4l79kTX_f2jbzyQZRjoiC0UpZXmwjg5E';
                const to ='vi';
                final url = Uri.parse('https://translation.googleapis.com/language/translate/v2?q=$text&target=$to&key=$apiKey',);
                final response = await http.post(url);
                // if (response.statusCode == 200)
                //   {
                //     final body = json.decode(response.body);
                //     final translations = body['data']['translations'];
                //     final translation = HtmlEscape().convert(
                //       translations.first['translatedText'],
                //     );
                //   }
                final translation = await text.translate(
                  from: 'en',
                  to: 'vi',
                );
                setState(() {
                  // print(translation.text);
                  translated = translation.text;
                });

              },
            ),
            Divider(height: 32,),
            Text("Vietnamese (VN)"),
            Text(
              translated,
              style: const TextStyle(
                fontSize: 36,
                color: Color.fromRGBO(4, 44, 88, 0.9),
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
