
import 'package:changilni_user/Immatriculation/UpdateInfo.dart';
import 'package:changilni_user/Model/InfoModel.dart';
import 'package:changilni_user/NetworkHandler.dart';
import 'package:flutter/material.dart';

class ImmatriculationCard extends StatelessWidget {
  const ImmatriculationCard({Key key,this.infomodel}) : super(key: key);

 final InfoModel infomodel;
 

  @override
  Widget build(BuildContext context) {
    final networkHandler = NetworkHandler();
     Future<void> _confirmDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure want delete this item?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                 InfoModel infoModel;
        networkHandler.delete(
              "/immatricule/delete/${infomodel.id}", infoModel);
                Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
              },
            ),
            FlatButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Card(
          color:Color(0xffDDDDDD), 
          child: Stack(
            children: <Widget>[
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                    height: 60,
                    width: MediaQuery.of(context).size.width - 30,
                    decoration: BoxDecoration(
                        color: Color(0xffDDDDDD),
                        borderRadius: BorderRadius.circular(8)),
                    child:Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:<Widget>[
                            IconButton(
              icon: Icon(Icons.car_rental),
              onPressed: () {},
              color: Color(0xFF27313B),
                iconSize: 40,
                 padding:EdgeInsets.only(bottom:40)
            ),
                                  Text(
                            infomodel.immatriculation,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          
                          ),
                          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => UpdateImma(this.infomodel)),
                            (route) => false);
            },
              color: Color(0xFF27313B),
                iconSize: 30,
                 padding:EdgeInsets.only(bottom:50)  
            ),
              IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {_confirmDialog();},
              color: Color(0xFF27313B),
                iconSize: 30,
                 padding:EdgeInsets.only(bottom:50)
            ),
                          ]
                        ),
                      ),
                    ),
                  ),
            ],
          ),
        
    ),
      );
  }
}