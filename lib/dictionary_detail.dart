import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:khoaluan/history_page.dart';
import 'package:khoaluan/provider/product_provider.dart';
import 'package:provider/provider.dart';

import 'dictionary_page.dart';
import 'homepage.dart';
import 'main.dart';
import 'package:flutter/material.dart';

import 'model/product_model.dart';

class DictionaryDetailPage extends StatefulWidget {
  const DictionaryDetailPage({Key? key}) : super(key: key);

  @override
  State<DictionaryDetailPage> createState() => _HomePageState();
}

class _HomePageState extends State<DictionaryDetailPage> {
  Color clr = Color.fromRGBO(4, 44, 88, 1);
  TextEditingController textEditingController = TextEditingController();
  FlutterTts flutterTts = FlutterTts();
  void texttoSpeech(String text) async
  {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setVolume(0.5);
    await flutterTts.setSpeechRate(0.6);
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }
  var searchControler,fixTitleControler,
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
      appBar: AppBar(
        backgroundColor: clr,
        automaticallyImplyLeading: true,
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

                      });
                    },
                    child: Text("[KLTN] Từ vựng", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),)
                ),
              ],
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(clr),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                            side: BorderSide(color: clr)
                        )
                    )
                ),
                onPressed: (){
                  setState(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HistoryPage()));
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 15,bottom: 15),
                  child: Icon(Icons.history),
                )
            ),
          ],
        ),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),

      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Container(
                width: 500,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: TextFormField(
                    controller: searchControler,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: Color.fromRGBO(4, 44, 88, 1)),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        label: Text("Tìm kiếm từ vựng",style:
                        TextStyle(
                            color: clr,
                            fontSize: 15
                        ),
                        ),
                        hintText: "Tìm kiếm",
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        prefixIcon: Icon(Icons.search)
                    ),
                    validator: (search){
                      if( search == null || search.isEmpty)
                        return "Từ khóa tìm kiếm rỗng";
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 10,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 5,left: 5),
                      padding: EdgeInsets.only(top: 5,bottom: 5
                      ),
                      child: ElevatedButton(
                        onPressed: (){
                          setState(() {
                            pp.list = pp.listTemp;
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => DictionaryPage()));
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 20.0),
                          primary: clr,
                          shape: StadiumBorder(),
                        ),
                        child: Text(
                          "Tất cả",style:
                        TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    ...pp.listCategory.map((e) {
                      return Container(
                        margin: EdgeInsets.only(right: 5,left: 5),
                        padding: EdgeInsets.only(top: 5,bottom: 5),
                        child: ElevatedButton(
                          onPressed: (){
                            setState(() {
                              pp.list = pp.listTemp;
                              Iterable<ProductModel> lt = pp.listTemp.where((ProductModel) {
                                return ProductModel.category==e.toString();
                              }).toList();
                              pp.list=lt.toList();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => DictionaryPage()));
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 20.0),
                            primary: clr,
                            shape: StadiumBorder(),
                          ),
                          child: Text(
                            e,style:
                          TextStyle(fontSize: 15,color: Colors.white),
                          ),
                        ),
                      );
                    }).toList()
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Text(pp.detail2.word.toString(),style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextButton(
                              onPressed: (){
                                texttoSpeech(pp.detail2.word.toString());
                              },
                              child: Icon(Icons.volume_up,size: 22,color: clr,)
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 50,),
                    Text("\/ "+pp.detail2.pronounce.toString() + " \/",style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                    ),),
                    SizedBox(height: 20,),
                    // Text(pp.detail2.meaning.toString(),style: TextStyle(
                    //   fontSize: 16,),
                    // ),
                    Html(data: pp.detail2.html),
                    SizedBox(height: 20,),
                    Text(pp.detail2.description.toString(),style: TextStyle(
                      fontSize: 16,),
                    ),
                    SizedBox(height: 200,),
                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
