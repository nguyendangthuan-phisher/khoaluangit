
import 'package:flutter/services.dart';
import 'package:khoaluan/dictionary_detail.dart';
import 'package:khoaluan/provider/product_provider.dart';
import 'package:provider/provider.dart';
import 'dictionary_page.dart';
import 'homepage.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'model/product_model.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

import 'navigation.dart';



class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List listHistory = [];
  List<ProductModel> listP = [];

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/history.json');
    final data = await json.decode(response);
    setState(() {
      listHistory = data['history'];
      for (var i=0; i < listHistory.length; i++)
      {
        ProductModel p = new ProductModel();
        p=p.producFromJson(listHistory[i]);
        listP.add(p);
        // print(i);
      }
    });

  }
  @override
  void initState()
  {
    super.initState();
    readJson();
  }
  Color clr = Color.fromRGBO(4, 44, 88, 1);
  var searchControler = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var pp = Provider.of<ProductProvider>(context);
    if(pp.list.length==0)
      pp.getList();
    _MyFormState()
    {
      pp.listHistory = listP;
    }
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
                    child: Text("[KLTN] Lịch sử", style: TextStyle(
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
                        MaterialPageRoute(builder: (context) => HomePage()));
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 15,bottom: 15),
                  child: Icon(Icons.home),
                ),
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
                padding: const EdgeInsets.only(left: 10, bottom: 20),
                child: Text("Lịch sử tra cứu từ vựng: ", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: clr,
                  fontSize: 16,
                ),),
              ),
              if(pp.listHistory.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text("[Lịch sử tra cứu trống ... ]"),
                ),

              ...pp.listHistory.map((e) {
                return TextButton(
                  onPressed: (){
                    setState(() {
                      pp.detail=e;
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DictionaryDetailPage()));
                    });
                  },
                  child: Container(
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(e.word.toString(),style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black
                            ),),
                            Text(e.meaning.toString(), overflow: TextOverflow.ellipsis,maxLines: 1,style: TextStyle(
                                color: Colors.black
                            ),),
                            Divider( endIndent: 30,color: Colors.grey,)
                          ],
                        ),
                      )
                  ),
                );
              }),

            ],
          ),
        ),
      ),
    );
  }



}


