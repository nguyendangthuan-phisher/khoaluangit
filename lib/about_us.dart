import 'package:flutter/material.dart';
import 'package:khoaluan/Navigation.dart';

class AboutUs extends StatelessWidget {
  AboutUs({Key? key}) : super(key: key);
  Color clr = Color.fromRGBO(4, 44, 88, 1);
  TextStyle style = TextStyle(
    fontSize: 12,
    color: Colors.white,
  );
  String src = 'assets/image/avata.jpg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navigation(),
      appBar: AppBar(
        backgroundColor: clr,
        centerTitle: true,
        title:
        Text("About Us"),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),
      ),
      body: Container(
          height: 1000,
          width: 1000,
          color: clr,
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10), // Image border
                  child: SizedBox.fromSize(
                    size: Size.fromRadius(90), // Image radius
                    child: Image.network('https://as1.ftcdn.net/v2/jpg/03/53/11/00/1000_F_353110097_nbpmfn9iHlxef4EDIhXB1tdTD0lcWhG9.jpg', fit: BoxFit.cover),
                  ),
                ),
              ),
              SizedBox(
                height: 150,
              ),
              Text("04/2023",style: style,),
              Text("Đại học Khoa học Huế",style: style,),
              Text("K43 Khoa Công nghệ thông tin",style: style,),
              Text("Nguyễn Đăng Thuận",style: style),
            ],
          )
      ),
    );
  }
}
