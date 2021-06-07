import 'package:changilni_user/pages/HomePage.dart';
import 'package:changilni_user/pages/WelcomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = WelcomePage();
  final storage=FlutterSecureStorage();
  @override
  void initState(){
    super.initState();
    checkLogin();
  }
  void checkLogin()async{
    String token = await storage.read(key: "token");
    if(token !=null){
      setState(() {
        page=HomePage();
      });
    }
    else{
       setState(() {
        page=WelcomePage();
      });
    }
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      home: page,
    );
     
  
}
}
