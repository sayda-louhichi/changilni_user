import 'package:changilni_user/pages/ForgotPassword.dart';
import 'package:changilni_user/pages/HomePage.dart';
import 'package:changilni_user/pages/SignUpPage.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../NetworkHandler.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key key}) : super(key: key);
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool vis = true;

  final _formKey = GlobalKey<FormState>();
  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String errorText;
  bool validate = false;
  bool circular = false;
  final storage = new FlutterSecureStorage();
  bool _isLogin = false;
  Map data;
  //final facebookLogin = FacebookLogin();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE4E4E4),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              height: 0,
              child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 150,
                      ),
                    ],
                  )),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image(
                  image: AssetImage('assets/logo.png'),
                  width: 400,
                  height: 400,
                  alignment: Alignment.center,
                ),
                emailTextField(hint:"Email",icon:Icons.email),
                 passwordTextField(hint:"Mot de passe",icon:Icons.vpn_key),
              
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPasswordPage()));
                      },
                      child: Text(
                        "Forgot Password ?",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
    
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SignUpPage(),
                        ));
                      },
                      child: Text(
                        "Créer compte ?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () async {
                    setState(() {
                      circular = true;
                    });
                    //Login Logic start here
                    Map<String, String> data = {
                      "email": _emailController.text,
                      "password": _passwordController.text,
                    };
                    var response =
                        await networkHandler.post("/user/login", data);

                    if (response.statusCode == 200 ||
                        response.statusCode == 201) {
                      Map<String, dynamic> output = json.decode(response.body);
                      print(output["token"]);
                      await storage.write(key: "token", value: output["token"]);
                      setState(() {
                        validate = true;
                        circular = false;
                      });
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                          (route) => false);
                    } else {
                      String output = json.decode(response.body);
                      setState(() {
                        validate = false;
                        errorText = output;
                        circular = false;
                      });
                    }

                    // login logic End here
                  },
                    child: Center(
                    child: circular
                        ? CircularProgressIndicator()
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xffE78200)),
                              child: Center(
                                  child: Text(
                                "Se connecter",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                  ),
                ),
                boxContainer(
                  "assets/facebook.png",
                  "Sign up with Facebook",
                  null,
                ),
                boxContainer(
                  "assets/google.png",
                  "Sign up with Google",
                  null,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget boxContainer(String path, String text, onClick) {
    return Container(
      alignment: Alignment.center,
      child: InkWell(
        onTap: onClick,
        child: Container(
          height: 60,
          width: MediaQuery.of(context).size.width - 140,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Image.asset(
                    path,
                    height: 25,
                    width: 25,
                  ),
                  SizedBox(width: 20),
                  Text(
                    text,
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /*onFBLogin() async {
    final result = await facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken;
        final response = await http.get(
            "https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=$token");
        final data1 = json.decode(response.body);
        print(data);
        setState(() {
          _isLogin = true;
          data = data1;
        });
        break;
      case FacebookLoginStatus.cancelledByUser:
        setState(() {
          _isLogin = false;
        });
        break;
      case FacebookLoginStatus.error:
        setState(() {
          _isLogin = false;
        });
        break;
    }
  }*/
Widget emailTextField({controller, hint, icon}) {
    return Container(
    
      margin: const EdgeInsets.only(top: 10,left:30,right: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 10),
        child:TextFormField(
            controller: _emailController,
             decoration: InputDecoration(
               errorText: validate ? null : errorText,
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon),
        ),
          )
    );
  }

  Widget passwordTextField({controller,hint,icon}) {
    return Container(
      margin: const EdgeInsets.only(top: 10,bottom: 50,left:30,right: 30),
      decoration: BoxDecoration(
         borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 10),
      child:TextFormField(
            controller: _passwordController,
            validator: (value) {
              if (value.isEmpty) return "Password can't be empty";
              if (value.length < 8) return "Password lenght must have >=8";
             return null;
            },
            obscureText: vis,
            decoration: InputDecoration(
              errorText: validate ? null : errorText,
              suffixIcon: IconButton(
                icon: Icon(vis ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    vis = !vis;
                  });
                },
              ),
              hintText: hint,
          prefixIcon: Icon(icon),
            ),
          )
        
    );
  }
  
/*
   Widget emailTextField() {
    return Column(
      children: [
        Text("Email"),
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
            errorText: validate ? null : errorText,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              ),
            ),
          ),
        )
      ],
    );
  }
  Widget passwordTextField() {
    return Column(
      children: [
        Text("Password"),
        TextFormField(
          controller: _passwordController,
          obscureText: vis,
          decoration: InputDecoration(
            errorText: validate ? null : errorText,
            suffixIcon: IconButton(
              icon: Icon(vis ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  vis = !vis;
                });
              },
            ),
            helperStyle: TextStyle(
              fontSize: 14,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              ),
            ),
          ),
        )
      ],
    );
  }*/
}