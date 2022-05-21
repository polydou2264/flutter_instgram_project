import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(
          iconTheme: IconThemeData(color: Colors.blue),
          appBarTheme: AppBarTheme(
              color: Colors.white,
              actionsIconTheme: IconThemeData(color: Colors.black)),
          textTheme: TextTheme(
              bodyText2: TextStyle(color: Colors.black)
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedItemColor: Colors.black)


      ),
      home: MyApp()
  ));
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var tab = 0;
  var a = TextStyle(color: Colors.black);

  getData() async {
    var result = await http.get(
        Uri.parse('https://codingapple1.github.io/app/data.json'));
    print(result.body);
    print('바보');
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Instagram'),
          actions: [
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (c){return Upload();})
              );
            }, icon: Icon(Icons.add_box_outlined),
            iconSize: 30,),
          ],
        ),

    body:[home(),Text('샵페이지')][tab],

    bottomNavigationBar: BottomNavigationBar(
    showUnselectedLabels: false,
    showSelectedLabels: false,
    onTap: (i){
    setState(() {
    tab = i;
    });
    },
    items: [
    BottomNavigationBarItem(
    label : '홈',
    icon: Icon(Icons.home_outlined),
    activeIcon: Icon(Icons.home)
    ),
    BottomNavigationBarItem(
    label : '샵',
    icon: Icon(Icons.shopping_bag_outlined),
    activeIcon: Icon(Icons.shopping_bag)
    )
    ],
    ),
    );
  }
}

class home extends StatelessWidget {
  const home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (c, i) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/picture.jpg'),
            Text('좋아요 100', style: TextStyle(fontWeight: FontWeight.bold),),
            Text('글쓴이'),
            Text('글내용')
          ],
        );
      },

    );
  }
}

class Upload extends StatelessWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('이미지업로드화면'),
          IconButton(onPressed: (){
            Navigator.pop((context));
            },
              icon: Icon(Icons.close))
        ],
      ),
    );
  }
}


