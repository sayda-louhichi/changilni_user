import 'dart:convert';
import 'package:changilni_user/pages/HomePage.dart';
import "package:flutter/material.dart";
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../NetworkHandler.dart';



class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  bool vis = true;
  final _formkey = GlobalKey<FormState>();
  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String errorText;
  bool validate = false;
  bool circular = false;
  final storage = new FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color(0xffE4E4E4),
        body: Form(
          key: _formkey,
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
               Image(
                  image: AssetImage('assets/logo.png'),
                  width: 400,
                  height: 400,
                  alignment: Alignment.center,
                ),
              usernameTextField(hint: "Nom", icon: Icons.person),
              emailTextField(hint:"Email",icon:Icons.email),
              passwordTextField(hint:"Mot de passe",icon:Icons.vpn_key),
              InkWell(
                onTap: () async {
                  setState(() {
                    circular = true;
                  });
                  await checkUser();
                  if (_formkey.currentState.validate() && validate) {
                    // we will send the data to rest server
                    Map<String, String> data = {
                      "username": _usernameController.text,
                      "email": _emailController.text,
                      "password": _passwordController.text,
                    };
                    print(data);
                    var responseRegister =
                        await networkHandler.post("/user/register", data);

                    //Login Logic added here
                    if (responseRegister.statusCode == 200 ||
                        responseRegister.statusCode == 201) {
                      Map<String, String> data = {
                        "email": _emailController.text,
                        "password": _passwordController.text,
                      };
                      var response =
                          await networkHandler.post("/user/login", data);

                      if (response.statusCode == 200 ||
                          response.statusCode == 201) {
                        Map<String, dynamic> output =
                            json.decode(response.body);
                        print(output["token"]);
                        await storage.write(
                            key: "token", value: output["token"]);
                        setState(() {
                          validate = true;
                          circular = false;
                        });
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>HomePage(),
                            ),
                            (route) => false);
                      } else {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text("Netwok Error")));
                      }
                    }

                    //Login Logic end here

                    setState(() {
                      circular = false;
                    });
                  } else {
                    setState(() {
                      circular = false;
                    });
                  }
                },
                child: circular
                    ? CircularProgressIndicator()
                    : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container( 
                              margin: EdgeInsets.only(top: 10,left:80,right: 80),
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                             
                                  color: Color(0xffE78200)),
                              child: Center(
                                  child: Text(
                                "Créer compte",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
              )
            ],
          ),
        ),
      
    );
  }

  checkUser() async {
    if (_emailController.text.length == 0) {
      setState(() {
        // circular = false;
        validate = false;
        errorText = "email Can't be empty";
      });
    } else {
      var response = await networkHandler
          .get("/user/checkuser/${_emailController.text}");
      if (response['Status']) {
        setState(() {
          // circular = false;
          validate = false;
          errorText = "email already taken";
        });
      } else {
        setState(() {
          // circular = false;
          validate = true;
        });
      }
    }
  }

  Widget usernameTextField({controller, hint, icon}) {
    return Container(
      margin: EdgeInsets.only(top: 10,left:30,right: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 10),
      child: TextFormField(
        controller: _usernameController,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }

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
            validator: (value) {
              if (value.isEmpty) return "Email can't be empty";
              if (!value.contains("@")) return "Email is Invalid";
              return null;
            },
             decoration: InputDecoration(
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
               border: InputBorder.none,
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
}