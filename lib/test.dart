import 'package:khoaluan/dictionary_detail.dart';
import 'package:khoaluan/history_page.dart';
import 'package:khoaluan/provider/product_provider.dart';
import 'package:provider/provider.dart';

import 'helper/DBHelper.dart';
import 'homepage.dart';
import 'main.dart';
import 'package:flutter/material.dart';

import 'model/dictionary_model.dart';
import 'model/product_model.dart';
import 'navigation.dart';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({Key? key}) : super(key: key);

  @override
  State<DictionaryPage> createState() => _HomePageState();
}

class _HomePageState extends State<DictionaryPage> {
  Color clr = Color.fromRGBO(4, 44, 88, 1);
  var searchController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  // List<DictionaryModel> node =  await DBHelper.db.getListDictionary();
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
                    child: Text("[KLTN]  Xem từ điển", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),)
                ),
              ],
            ),

            SizedBox(width: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: ElevatedButton(
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
            ),
          ],
        ),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),

      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10,),
              Row(
                children: [
                  Container(
                    width: 400,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: TextFormField(
                        controller: searchController,
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
                        pp.list = pp.listTemp.where((e) => e.word!.contains(searchController.text)).toList();
                        // print(searchController.text);
                        setState(() {

                          // Navigator.of(context).push(MaterialPageRoute(
                          //   builder: (context) => DictionaryPage(),
                          // ));
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
              ...pp.list.map((e) {
                return TextButton(
                  onPressed: (){
                    setState(() {
                      pp.detail=e;
                      pp.listHistory.add(e);
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
              })

            ],
          ),
        ),
      ),
    );
  }
}
