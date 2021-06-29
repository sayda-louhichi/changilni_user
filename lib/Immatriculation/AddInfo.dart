
import 'package:changilni_user/CustumWidget/ImmatriculationCard.dart';
import 'package:changilni_user/Model/InfoModel.dart';
import 'package:changilni_user/pages/HomePage.dart';
import 'package:flutter/material.dart';
import '../NetworkHandler.dart';

class AddImmatriculation extends StatefulWidget {
  AddImmatriculation({Key key}) : super(key: key);

  @override
  _AddImmatriculationState createState() => _AddImmatriculationState();
}
  TextEditingController _immatriculation = TextEditingController();
    final _formKey = GlobalKey<FormState>();
      NetworkHandler networkHandler = NetworkHandler();
      String immatriculation;
class _AddImmatriculationState extends State<AddImmatriculation> {
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
        actions: <Widget>[
          FlatButton(
            onPressed: () {
             /* if (_formKey.currentState.validate()) {
                showModalBottomSheet(
                  context: context,
                  builder: ((builder) => ImmatriculationCard(
                        infomode
                      )),
                );
              }*/
            },
            child: Text(
              "Preview",
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
          )
        ],
      ),
    body: Form(
      key: _formKey,
          child: ListView(children: <Widget>[
immatriculationTextField(),
addButton(),
      ],),
    ),
    );
  }

   Widget immatriculationTextField() {
    return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: TextFormField(
          controller: _immatriculation,
          validator: (value) {
            if (value.isEmpty) {
              return "champs imma est obligatoire";
            }
            return null;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.teal,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.orange,
                width: 2,
              ),
            ),
            labelText: "immatriculation",
          ),
          maxLines: null,
        ),
    );
  }
  Widget addButton(){
    return InkWell(
      onTap: () async {
        if (_formKey.currentState.validate()) {
          InfoModel infoModel =
              InfoModel(immatriculation: _immatriculation.text);
        await networkHandler.post1(
              "/immatricule/add", infoModel.toJson());
         setState(() {
           Navigator.pushAndRemoveUntil(
                      context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                          (route) => false);
         });
          
        }
        
      },
      child: Center(
        child: Container(
          height: 50,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.teal),
          child: Center(
              child: Text(
            "Ajouter immatriculation",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );
  }
}
