import 'package:changilni_user/Immatriculation/Immatriculations.dart';
import "package:flutter/material.dart";
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE4E4E4),
    body: ListView(
      children:<Widget>[
         Immatriculations(
          url: "/immatricule/getOwnImmatriculation",
        ),
        ]
      ),
    );
  }
}