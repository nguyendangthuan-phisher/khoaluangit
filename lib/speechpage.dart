import 'package:flutter_tts/flutter_tts.dart';
import 'package:khoaluan/dictionary_page.dart';
import 'package:khoaluan/provider/product_provider.dart';
import 'package:provider/provider.dart';

import 'homepage.dart';
import 'main.dart';
import 'package:flutter/material.dart';

import 'model/product_model.dart';
import 'navigation.dart';

class SpeechPage extends StatefulWidget {
  const SpeechPage({Key? key}) : super(key: key);

  @override
  State<SpeechPage> createState() => _SpeechPageState();
}

class _SpeechPageState extends State<SpeechPage> {
  Color clr = Color.fromRGBO(4, 44, 88, 1);
  TextEditingController textEditingController = TextEditingController();
  FlutterTts flutterTts = FlutterTts();
  void textToSpeech(String text) async
  {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setVolume(0.7);
    // await flutterTts.setSpeechRate(0.8);
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  var speechControler,fixTitleControler,
      addTitleControler,addSubTitleControler,
      addCategoryControler,addThumbControler,
      addDescriptionControler,addSourceControler = TextEditingController();
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
                    child: Text("[KLTN] Text to voice", style: TextStyle(
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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            Container(
              width: 500,
              child: Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,),
                child: TextFormField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: Color.fromRGBO(4, 44, 88, 1)),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      label: Text("Chuyển văn bản thành giọng nói",style:
                      TextStyle(
                          color: clr,
                          fontSize: 15
                      ),
                      ),
                      hintText: "Nhập từ cần đọc",
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      prefixIcon: Icon(Icons.text_snippet_outlined)
                  ),
                  validator: (search){
                    if( search == null || search.isEmpty)
                      return "Văn bản rỗng";
                    return null;
                  },
                ),
              ),
            ),
            TextButton(
              onPressed: (){
                textToSpeech(textEditingController.text);
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: clr,
                ),
                child: Center(
                    child: Icon(Icons.volume_up,color: Colors.white,)),
              ),
            )

          ],
        ),
      ),
    );
  }
}
