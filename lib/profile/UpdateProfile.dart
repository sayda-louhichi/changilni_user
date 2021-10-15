import 'dart:io';

import 'package:changilni_user/Model/ProfileModel.dart';
import 'package:changilni_user/NetworkHandler.dart';
import 'package:changilni_user/pages/HomePage.dart';
import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';

class UpdateProfile extends StatefulWidget {

  UpdateProfile(this.profilemodel);

  final ProfileModel profilemodel;

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final networkHandler = NetworkHandler();
  bool circular = false;
  final _formKey = GlobalKey<FormState>();
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  TextEditingController _username = TextEditingController();
  TextEditingController _tel = TextEditingController();
  TextEditingController _cin = TextEditingController();
  TextEditingController _adress = TextEditingController();
   String username,tel,adress,cin;
  void initState() {
    super.initState();
//email = widget.profilemodel.email;

 _username = new TextEditingController(text: widget.profilemodel.username);
 _tel = new TextEditingController(text: widget.profilemodel.tel);
   _adress = new TextEditingController(text: widget.profilemodel.adress);
_cin = new TextEditingController(text: widget.profilemodel.cin);  
   //fetchData();
  }
 ProfileModel profileModel = ProfileModel();
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
        body: Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: <Widget>[
          imageProfile(),
          SizedBox(height: 20),
          usernameTextField(),
          SizedBox(height: 20),
          cinTextField(),
          SizedBox(height: 20),
          telTextField(),
          SizedBox(height: 20),
          adressTextField(),
          SizedBox(height: 20),
          InkWell(
            onTap: () async {
              setState(() {
                  circular = true;
                });
                   if (_formKey.currentState.validate()) {
                       
                      Map<String, String> data = {
                    "username": _username.text,
                    "tel": _tel.text,
                    "adress": _adress.text,
                    "cin":_cin.text,
                  };        
                       _formKey.currentState.save();
                       networkHandler.patch("/profile/update", data);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                          (route) => false);
                        }  
                },
            child: Center(
              child: Container(
               width: 150,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xffE78200),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: circular
                      ? CircularProgressIndicator()
                      : Text(
                          "Modifier",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }

  Widget imageProfile() {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 80.0,
            backgroundImage: _imageFile == null
                ? AssetImage("assets/sayda.jpg")
                : FileImage(File(_imageFile.path)),
          ),
          Positioned(
              bottom: 20.0,
              right: 20.0,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context, builder: ((builder) => bottomSheet()));
                      
                },
                child: Icon(
                  Icons.camera_alt,
                  color: Color(0xffE78200),
                  size: 28.0,
                ),
              ))
              
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
        height: 100.0,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(children: <Widget>[
          Text(
            "sélectionner une photo",
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Caméra"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallerie"),
            ),
          ])
        ]));
  }

  void takePhoto(ImageSource source) async {
    final PickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = PickedFile;
    });
  }

  Widget usernameTextField() {
    /*return TextFormField(
      controller: _username,
      validator: (value) {
        if (value.isEmpty) return "Nom est obligatoire";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Color(0xffE78200),
          width: 2,
        )),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.grey,
        ),
        labelText: "Nom",
        labelStyle: TextStyle(color: Color(0xFF27313B)),
        helperText: "Nom est obligatoire",
        hintText: "sayda",
      ),
    );*/
    return  TextFormField(
                    controller: _username,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'name',
                      fillColor: Colors.grey[300],
                      filled: true,
                    ),
                    validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter country';
                                  }
                                  return null;
                                },
                  onSaved: (value) => username = value,
                  );
  
  }

  /*Widget emailTextField() {
    return TextFormField(
      controller: _email,
      validator: (value) {
        if (value.isEmpty) return "Email est obligatoire";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Color(0xffE78200),
          width: 2,
        )),
        prefixIcon: Icon(
          Icons.email,
          color: Colors.grey,
        ),
        labelText: "Email",
        labelStyle: TextStyle(color: Color(0xFF27313B)),
        helperText: "Email est obligatoire",
        hintText: "sayda@gmail.com",
      ),
    );
  }*/

  Widget cinTextField() {
    /*return TextFormField(
      controller: _cin,
      validator: (value) {
        if (value.isEmpty) return "CIN est obligatoire";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Color(0xffE78200),
          width: 2,
        )),
        prefixIcon: Icon(
          Icons.perm_identity_rounded,
          color: Colors.grey,
        ),
        labelText: "CIN",
        labelStyle: TextStyle(color: Color(0xFF27313B)),
        helperText: "CIN est obligatoire",
        hintText: "09628611",
      ),
    );*/
     return  TextFormField(
                    controller: _cin,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'tel',
                      fillColor: Colors.grey[300],
                      filled: true,
                    ),
                    validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter country';
                                  }
                                  return null;
                                },
                      onSaved: (value) => cin = value,
                  );
  }

  Widget telTextField() {
   /* return TextFormField(
      controller: _tel,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Color(0xffE78200),
          width: 2,
        )),
        prefixIcon: Icon(
          Icons.phone,
          color: Colors.grey,
        ),
        labelText: "Tel",
        labelStyle: TextStyle(color: Color(0xFF27313B)),
        hintText: "51396157",
      ),
    );*/
     return  TextFormField(
                    controller: _tel,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'tel',
                      fillColor: Colors.grey[300],
                      filled: true,
                    ),
                    validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter country';
                                  }
                                  return null;
                                },
                      onSaved: (value) => tel = value,
                  );
  }

  Widget adressTextField() {
    /*return TextFormField(
      controller: _adress,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Color(0xffE78200),
          width: 2,
        )),
        prefixIcon: Icon(
          Icons.location_on,
          color: Colors.grey,
        ),
        labelText: "Adresse",
        labelStyle: TextStyle(color: Color(0xFF27313B)),
        hintText: "Rue il jam rades",
      ),
    );*/
     return  TextFormField(
                    controller: _adress,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'tel',
                      fillColor: Colors.grey[300],
                      filled: true,
                    ),
                    validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter country';
                                  }
                                  return null;
                                },
                      onSaved: (value) => adress = value,
                  );
  }
}
