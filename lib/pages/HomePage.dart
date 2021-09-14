import 'package:changilni_user/Immatriculation/AddInfo.dart';
import 'package:changilni_user/Screens/HomeScreen.dart';
import 'package:changilni_user/pages/WelcomePage.dart';
import 'package:changilni_user/profile/ProfileScreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  int currentState = 0 ;
  List<Widget> widgets = [ HomeScreen(), ProfileScreen()];
    final storage = FlutterSecureStorage();
    List<String> titleString = ["Home Page", "Profile Page"];
     final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    @override
  void initState() {
    super.initState();
     
    
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
       // _showItemDialog(message);
      },
      //onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        //_navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        //_navigateToItemDetail(message);
      },
    );}
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(children: <Widget>[
          DrawerHeader(
            child: Column(
              children: <Widget>[
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("@username"),
              ],
            ),
          ),
          
          ListTile(
              title: Text("Logout"),
              trailing: Icon(Icons.power_settings_new),
              onTap: logout,
            ),
        ]),
      ),
      backgroundColor: Color(0xffE4E4E4),
      appBar: AppBar(
        backgroundColor: Color(0xffE78200),
        title: Text(titleString[currentState],
          style: TextStyle(color: Color(0xFF27313B)),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.notifications),
          color:Color(0xFF27313B),
           onPressed: () {})
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffE78200),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddImmatriculation(),
                        ));
        },
        child: Text(
          '+',
          style: TextStyle(fontSize: 35,
          color: Color(0xFF27313B)),
          
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color:Color(0xffE78200),
        shape: CircularNotchedRectangle(),
        notchMargin: 12,
        child: Container(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.home),
                  color: currentState == 0 ? Colors.white:Color(0xFF27313B),
                  onPressed: () {
                    setState(() {
                      currentState = 0 ;
                    });
                  },
                  iconSize: 40,
                ),
                IconButton(
                  icon: Icon(Icons.person),
                 color: currentState == 1 ? Colors.white:Color(0xFF27313B),
                  onPressed: () { 
                    setState(() {
                      currentState = 1 ;
                    });},
                  iconSize: 40,
                ),
              ],
            ),
          ),
        ),
      ),
      body:widgets[currentState]
    );
  }
  void logout() async {
    await storage.delete(key: "token");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => WelcomePage()),
        (route) => false);
  }
}
