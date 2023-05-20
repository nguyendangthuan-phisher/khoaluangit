
import 'package:flutter/material.dart';
import 'package:khoaluan/dictionary_detail.dart';
import 'package:khoaluan/helper/DBHelper.dart';
import 'package:khoaluan/provider/product_provider.dart';
import 'package:provider/provider.dart';

import 'model/dictionary_model.dart';

class DictionaryList extends StatefulWidget {
  const DictionaryList({Key? key}) : super(key: key);

  @override
  State<DictionaryList> createState() => _DictionaryListState();
}

class _DictionaryListState extends State<DictionaryList> {

  late Future<List<DictionaryModel>> list;
  @override
  void initState() {
    list = DBHelper.db.getListDictionary();
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double maxWidth= MediaQuery.of(context).size.width;
    var pp = Provider.of<ProductProvider>(context);
    // pp.detail2 = list;
    return FutureBuilder(
      future: list,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasData){
            var data = snapshot.data;
            return ListView.builder(
                scrollDirection: Axis.vertical,
              itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {

                  return TextButton(
                    onPressed: (){
                      setState(() {
                        pp.detail2 = data[index];
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => DictionaryDetailPage()));
                      });
                    },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${data[index].word}",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black
                            ),),
                            SizedBox(height: 5,),
                            Container(
                                width: maxWidth,
                                child: Text("${data[index].description}", maxLines: 1,style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),)
                            ),
                            Divider(indent: 0,color: Colors.grey, endIndent: 15,),
                          ],
                        ),
                      )
                  );
                }
            );
          } else {
            return CircularProgressIndicator();
          }
        }
    );
  }
}
