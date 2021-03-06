import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
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
  var userImage;

  saveData() async {
    var storage = await SharedPreferences.getInstance();
    storage.setString('name', 'john');
    var result = storage.get('name');
    print(result);

  }





  getData() async {
    var result = await http.get(
        Uri.parse('https://codingapple1.github.io/app/data.json'));
  }

  @override
  void initState() {
    super.initState();
    saveData();
    getData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Instagram'),
          actions: [
            IconButton(onPressed: () async {
              var picker = ImagePicker();
              var image = await picker.pickImage(source: ImageSource.gallery);
              if(image != null){
                setState((){
                  userImage = File(image.path);
                });
              }

              Navigator.push(context, MaterialPageRoute(builder: (c){return Upload(userImage: userImage);})
              );
            }, icon: Icon(Icons.add_box_outlined),
            iconSize: 30,),
          ],
        ),

    body:[home(),Text('????????????')][tab],

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
    label : '???',
    icon: Icon(Icons.home_outlined),
    activeIcon: Icon(Icons.home)
    ),
    BottomNavigationBarItem(
    label : '???',
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
            Text('????????? 100', style: TextStyle(fontWeight: FontWeight.bold),),
            Text('?????????'),
            Text('?????????')
          ],
        );
      },

    );
  }
}

class Upload extends StatelessWidget {
  const Upload({Key? key, this.userImage}) : super(key: key);
  final userImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.file((userImage)),
          Text('????????????????????????'),
          IconButton(onPressed: (){
            Navigator.pop((context));
            },
              icon: Icon(Icons.close))
        ],
      ),
    );
  }
}


