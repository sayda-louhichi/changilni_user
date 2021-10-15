import 'dart:async';
import 'package:changilni_user/pages/SignInPage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds:10),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (
              BuildContext context) =>SignInPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     //#2CD889
      backgroundColor: Color(0xffE4E4E4),
      body: Column(
           crossAxisAlignment:CrossAxisAlignment.center,
          children: <Widget>[
             SizedBox(
            height: 200,
          ),
            Lottie.asset('assets/lottie/user.json',
            width: 300,
            height: 300,
            fit: BoxFit.fill,),
             SizedBox(
            height: 100,
          ),
            Text(
                  "Voir l'emplacement de votre voiture en parc des fourriéres",
                  
                  style: TextStyle(
                      color: Color(0xff27313B),
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,),
                      textAlign: TextAlign.center,
                ),]
      ),
    );
  }

  
}