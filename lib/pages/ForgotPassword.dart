import 'package:changilni_user/pages/SignInPage.dart';
import "package:flutter/material.dart";
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../NetworkHandler.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({Key key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
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
      body: Container(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Nouveau Password",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
               emailTextField(hint:"Email",icon:Icons.email),
                SizedBox(
                  height: 15,
                ),
                passwordTextField(hint:"Mot de passe",icon:Icons.vpn_key),
                SizedBox(
                  height: 20,
                ),

                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () async {
                    Map<String, String> data = {
                      "password": _passwordController.text
                    };
                    print("/user/update/${_emailController.text}");
                    var response = await networkHandler.patch(
                        "/user/update/${_emailController.text}", data);

                    if (response.statusCode == 200 ||
                        response.statusCode == 201) {
                      print("/user/update/${_emailController.text}");
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInPage()),
                          (route) => false);
                    }

                    // login logic End here
                  },
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffE78200),
                    ),
                    child: Center(
                      child: circular
                          ? CircularProgressIndicator()
                          : Text(
                              "Modifier Password",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
                // Divider(
                //   height: 50,
                //   thickness: 1.5,
                // ),
              ],
            ),
          ),
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
           border: InputBorder.none,
            ),
          )
        
    );
  }
}