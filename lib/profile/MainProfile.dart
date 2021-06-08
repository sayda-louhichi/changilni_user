import 'package:changilni_user/Model/ProfileModel.dart';
import 'package:changilni_user/NetworkHandler.dart';
import "package:flutter/material.dart";

class MainProfile extends StatefulWidget {
  const MainProfile({Key key}) : super(key: key);

  @override
  _MainProfileState createState() => _MainProfileState();
}

class _MainProfileState extends State<MainProfile> {
  bool circular = true;
  final networkHandler = NetworkHandler();
  ProfileModel profileModel = ProfileModel();
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    var response = await networkHandler.get("/profile/getData");
    setState(() {
      profileModel = ProfileModel.fromJson(response["data"]);
      circular = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE4E4E4),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffE4E4E4),
        /*leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
          color: Color(0xFF27313B),
        ),*/
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
            color: Color(0xFF27313B),
          ),
        ],
      ),
      body: circular
          ? Center(child: CircularProgressIndicator())
          : ListView(children: <Widget>[
              head(),
              Divider(
                thickness: 0.8,
              ),
              otherDetails("Nom", profileModel.username),
              otherDetails("Adresse", profileModel.adress),
              otherDetails("Cin", profileModel.cin),
              otherDetails("Téléphone", profileModel.tel),
              Divider(
                thickness: 0.8,
              ),
            ]),
    );
  }

  Widget head() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                backgroundImage: NetworkHandler().getImage(profileModel.email),
                radius: 50,
              ),
            ),
            Text(profileModel.email,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            
          ]),
    );
  }

  Widget otherDetails(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("$label :",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(
              value,
              style: TextStyle(fontSize: 16),
            )
          ]),
    );
  }
}
