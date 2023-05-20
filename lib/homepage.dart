import 'package:khoaluan/dictionary_page.dart';
import 'package:khoaluan/history_page.dart';
import 'package:khoaluan/provider/product_provider.dart';
import 'package:khoaluan/speechpage.dart';
import 'package:khoaluan/translate_page.dart';
import 'package:provider/provider.dart';

import 'main.dart';
import 'package:flutter/material.dart';

import 'model/product_model.dart';
import 'navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color clr = Color.fromRGBO(4, 44, 88, 1);

  var searchControler = TextEditingController();
  TextStyle mainButton = TextStyle(
    fontSize: 20,
    color: Colors.white,
  );
  Container mainContainer(String text, Icon icon)
  {

    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: clr,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),

        height: 70,
        width: 440,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30,right: 60),
              child: icon,
            ),
            Text(text, style: mainButton,)
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth= MediaQuery.of(context).size.width;
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
                    child: Text("[KLTN]  Từ điển Anh - Việt", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),)
                ),
              ],
            ),

          ],
        ),
        titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight:  FontWeight.bold,
        ),

      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              Row(
                children: [
                  Container(
                    width: maxWidth-100,
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
                  ElevatedButton(
                      onPressed: () {
                        setState(() {

                          pp.list = pp.listTemp.where((e) => e.word!.contains(searchControler.text)).toList();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DictionaryPage(),
                          ));
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: clr
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 15,left: 10, right: 10),
                        child: const Text("Search",style: TextStyle(
                          fontSize: 14,
                        ),),
                      )),
                ],
              ),

              SizedBox(height: 100,),
              TextButton(
                onPressed: (){
                  setState(() {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DictionaryPage()));
                  });
                },
                child: mainContainer("Xem từ điển", Icon(Icons.library_books_outlined,color: Colors.white,)),
              ),
              SizedBox(height: 30,),
              TextButton(
                onPressed: (){
                  setState(() {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TranslatePage()));
                  });
                },
                child: mainContainer("Dịch từ", Icon(Icons.translate,color: Colors.white,)),
              ),
              SizedBox(height: 30,),
              TextButton(
                onPressed: (){
                  setState(() {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SpeechPage()));
                  });
                },
                child: mainContainer("Text to voice", Icon(Icons.volume_up_outlined,color: Colors.white,)),
              ),
              SizedBox(height: 30,),
              TextButton(
                onPressed: (){
                  setState(() {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HistoryPage()));
                  });
                },
                child: mainContainer("Lịch sử tra cứu từ vựng",  Icon(Icons.history,color: Colors.white,)),
              ),
              SizedBox(height: 100,),
              Text(" Nguyễn Đăng Thuận - Khoá luận tốt nghiệp - 2023",style: TextStyle(
                color: clr,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
