import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:khoaluan/about_us.dart';
import 'package:khoaluan/dictionary.dart';
import 'package:khoaluan/history_page.dart';
import 'package:khoaluan/homepage.dart';
import 'package:khoaluan/speechpage.dart';
import 'package:khoaluan/translate_page.dart';

class Navigation extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  Color clr = Color.fromRGBO(4, 44, 88, 1);
  int inbox = 5;
  String inboxText(){
    return " [ "+ inbox.toString() +" ]";
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: clr,
        child: ListView(
          children: <Widget>[
            buildHeader(context),
            Divider(color: Colors.white70,endIndent: 20,indent: 20,),
            buildMenuItem(
              text: "Home",
              icon: Icons.home_rounded,
              onClicked: () => selectedItem(context, 5),
            ),
            buildMenuItem(
              text: "Xem từ điển",
              icon: Icons.library_books_rounded,
              onClicked: () => selectedItem(context, 0),
            ),
            buildMenuItem(
              text: "Dịch từ",
              icon: Icons.translate,
              onClicked: () => selectedItem(context, 1),
            ),
            buildMenuItem(
              text: "Text to voice",
              icon: Icons.volume_up,
              onClicked: () => selectedItem(context, 2),
            ),
            buildMenuItem(
              text: "Lịch sử tra cứu từ vựng",
              icon: Icons.history,
              onClicked: () => selectedItem(context, 3),
            ),
            const SizedBox( height: 8,),
            Divider(color: Colors.white70,endIndent: 20,indent: 20,),
            const SizedBox( height: 8,),
            buildMenuItem(
                text: "About us",
                icon: Icons.info,
                onClicked: () => selectedItem(context, 4)
            ),
          ],
        ),
      ),
    );
  }
}
Widget buildMenuItem( {
  required String text,
  required IconData icon,
  VoidCallback? onClicked,
})
{
  return ListTile(
    minVerticalPadding: 10,
    hoverColor: Color.fromRGBO(0, 0, 0, 0.4),
    leading: Icon(icon,color: Colors.white,),
    title: Text(text,style:
    TextStyle(
        fontSize: 15,
        color: Colors.white
    ),),
    onTap: onClicked,
  );
}
void selectedItem(BuildContext context,int index) {
  switch (index) {
    case 0:
      {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DictionaryPage(),
        ));
        break;
      }
    case 1:
      {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => TranslatePage(),
        ));
        break;
      }
    case 2:
      {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SpeechPage(),
        ));
        break;
      }
    case 3:
      {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HistoryPage(),
        ));
        break;
      }
    case 4:
      {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AboutUs(),
        ));
        break;
      }
    case 5:
      {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomePage(),
        ));
        break;
      }
  }
}
Widget buildHeader(BuildContext context) => Material(
    color: Color.fromRGBO(4, 44, 88, 1),
    child: InkWell(
      hoverColor: Color.fromRGBO(0, 0, 0, 0.2),
      onTap: (){
        //close navigation
        Navigator.pop(context);

        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => StudentInformations()
        // )
        // );
      },
      child: Container(
        padding: EdgeInsets.only(
          top: 12 + MediaQuery.of (context) .padding. top,
          bottom: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://as1.ftcdn.net/v2/jpg/03/53/11/00/1000_F_353110097_nbpmfn9iHlxef4EDIhXB1tdTD0lcWhG9.jpg'),
            ),
            SizedBox(
              height: 24,
            ),
            Text("Nguyễn Đăng Thuận",style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text("ndthuan.husc@gmail.com",style: TextStyle(
                  fontSize: 12,
                  color: Colors.white
              ),),
            ),
          ],
        ),
      ),
    )
);
