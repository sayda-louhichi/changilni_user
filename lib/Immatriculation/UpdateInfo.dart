
import 'package:changilni_user/Model/InfoModel.dart';
import 'package:changilni_user/NetworkHandler.dart';
import 'package:changilni_user/pages/HomePage.dart';
import "package:flutter/material.dart";
import 'dart:convert';

class UpdateImma extends StatefulWidget {

  UpdateImma(this.infomodel);

  final InfoModel infomodel;

  @override
  _UpdateImmaState createState() => _UpdateImmaState();
}

class _UpdateImmaState extends State<UpdateImma> {
  final networkHandler = NetworkHandler();
  bool circular = false;
  List<InfoModel> data = [];
  final _formKey = GlobalKey<FormState>();
 
  TextEditingController _immatriculation = TextEditingController();
  
   String immatriculation;
   String id;
  void initState() {
    super.initState();


 _immatriculation = new TextEditingController(text: widget.infomodel.immatriculation);
 
  fetchData();
  }
 InfoModel infoModel = InfoModel();
 void fetchData() async {
    var response = await networkHandler.get("/immatricule/getDataImma");
    setState(() {
      infoModel = InfoModel.fromJson(response["data"]);
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
         
          usernameTextField(),
          SizedBox(height: 20),
         
          InkWell(
            onTap: () async {
              setState(() {
                  circular = true;
                });
                   if (_formKey.currentState.validate()) {
                       
                      Map<String, String> data = {
                    "immatriculation": _immatriculation.text,
                    "id":infoModel.id,
                  };        
                       _formKey.currentState.save();
                       networkHandler.patch("/immatricule/update/${infoModel.immatriculation}",data);
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
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xFF27313B),
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

  

  Widget usernameTextField() {
    
    return  TextFormField(
                    controller: _immatriculation,
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
                  onSaved: (value) => immatriculation = value,
                  );
  
  }

 
}

/*import 'dart:async';

import 'package:changilni_user/Model/InfoModel.dart';
import 'package:changilni_user/pages/HomePage.dart';
import 'package:flutter/material.dart';
import '../NetworkHandler.dart';

class UpdateImmatriculation extends StatefulWidget {
  UpdateImmatriculation(this.infomodel);
  final InfoModel infomodel;

  @override
  _UpdateImmatriculationState createState() => _UpdateImmatriculationState();
}
  

class _UpdateImmatriculationState extends State<UpdateImmatriculation> {
    final _formKey = GlobalKey<FormState>();
    String id;
      NetworkHandler networkHandler = NetworkHandler();
        TextEditingController _immatriculationController = TextEditingController();
           String immatriculation;
          bool circular = false;
         
      
     void initState() {
    super.initState();
 
 _immatriculationController = new TextEditingController(text: widget.infomodel.immatriculation);  

  fetchData();
  }
 InfoModel infoModel = InfoModel();
  void fetchData() async {
    var response = await networkHandler.get("/immatricule/getDataImma");
    setState(() {
      infoModel = InfoModel.fromJson(response["data"]);
      circular = false;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
        backgroundColor: Colors.white54,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.clear,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
    body: Form(
      key: _formKey,
          child: ListView(children: <Widget>[
immaTextField(),
InkWell(
            onTap: () async  {
              setState(() {
                  circular = true;

                });
                  if (_formKey.currentState.validate()) {
                      Map<String, String> data = {
                      "immatriculation": _immatriculationController.text
                    };
                         _formKey.currentState.save();
                       await networkHandler.patch1("/immatricule/update/${_immatriculationController.text}", data);
    
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
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xFF27313B),
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
          ),
      ],),
    ),
    );
  }

   Widget immaTextField(){
    return TextFormField(
                      controller: _immatriculationController,
                      validator: (String value) =>
                          value.isEmpty ? "Name required" : null,
                      onSaved: (value) => immatriculation = value,
                     
                      maxLines: null,
                      autofocus: false,
                      
                    );
                   
  }
 
}

 
*/