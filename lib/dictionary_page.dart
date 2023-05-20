import 'package:flutter_html/flutter_html.dart';
import 'package:khoaluan/dictionary_detail.dart';
import 'package:khoaluan/dictionary_list.dart';
import 'package:khoaluan/history_page.dart';
import 'package:khoaluan/provider/product_provider.dart';
import 'package:provider/provider.dart';

import 'homepage.dart';
import 'main.dart';
import 'package:flutter/material.dart';

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
      body: Center(
          child: DictionaryList()
      ),
    );
  }
}
