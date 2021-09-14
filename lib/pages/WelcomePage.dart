import 'package:changilni_user/pages/SignInPage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key}) : super(key: key);
  @override
  _WelcomePageState createState() => _WelcomePageState();
}
//gris foncé texte #707070
//bleu #27313B
//gris champs #DDDDDD
class _WelcomePageState extends State<WelcomePage> {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE4E4E4),
      body: Column(
           crossAxisAlignment:CrossAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('assets/logo.png'),
              width: 600,
              height: 600,
            ),
            Container(
              width: 150,
              height: 50,
             
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xffE78200),
              ),
              child: FlatButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => SignInPage()));
                },
                child: Text(
                  "Bienvenue",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ]),
    );
  }
}