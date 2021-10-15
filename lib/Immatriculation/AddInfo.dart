
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
       String errorText;
  bool validate = false;
      
class _AddImmatriculationState extends State<AddImmatriculation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE4E4E4),
appBar: AppBar(
        backgroundColor:Color(0xffE78200),
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
         /* FlatButton(
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
            
          )*/
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
     return Container(
    
      margin: const EdgeInsets.only(top: 10,left:30,right: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
       
      ),
      padding: EdgeInsets.only(left: 10),

    child: TextFormField(
      controller: _immatriculation,
      validator: (value) {
        if (value.isEmpty) return "Immatriculation est obligatoire";

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
          Icons.car_rental,
          color: Colors.grey,
        ),
        labelText: "Immatriculation",
        labelStyle: TextStyle(color: Color(0xFF27313B)),
        helperText: "Immatriculation est obligatoire",
        hintText: "1234tu123",
      ),
     )
     );
  }
 /* checkImma() async {
      var response = await networkHandler
          .get("/immatricule/check/${_immatriculation.text}");
      if (response['Status']) {
           setState(() {
          // circular = false;
          validate = false;
          errorText = "L'immatricule est existe";
        });
      } else {
        setState(() {
          // circular = false;
          validate = true;
          errorText="L'immatricule n'existe pas";
        });
      }
      }*/
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
              borderRadius: BorderRadius.circular(10), color: Color(0xffE78200),),
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
