import 'package:changilni_user/NetworkHandler.dart';
import 'package:changilni_user/profile/CreateProfile.dart';
import 'package:changilni_user/profile/MainProfile.dart';
import "package:flutter/material.dart";

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  NetworkHandler networkHandler = NetworkHandler();
  Widget page = CircularProgressIndicator();
  @override
  void initState() {
    super.initState();
    checkProfile();
  }

  void checkProfile() async {
    var response = await networkHandler.get("/profile/checkProfile");
    if (response["status"] == true) {
      setState(() {
        page = MainProfile();
      });
    } else {
      setState(() {
        page = button();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xffE4E4E4),
     body: page);
  }

  Widget showProfile() {
    return Center(
      child: Text("Profile Dtat is avalable"),
    );
  }

  Widget button() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 70),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateProfile()));
              },
              child: Center(
                child: Container(
                  height: 60,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Color(0xFF27313B),
                      borderRadius: BorderRadius.circular(200)
                    ),
                  child: Center(
                      child: Text("Ajouter Profil",
                          style: TextStyle(color: Colors.white, fontSize: 25))),
                ),
              ),
            )
          ]),
    );
  }
}
