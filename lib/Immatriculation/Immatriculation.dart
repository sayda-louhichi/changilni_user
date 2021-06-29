
import 'package:changilni_user/Immatriculation/AddInfo.dart';
import 'package:changilni_user/Immatriculation/UpdateInfo.dart';
import 'package:changilni_user/Model/InfoModel.dart';
import 'package:changilni_user/NetworkHandler.dart';
import 'package:flutter/material.dart';

class Immatriculation extends StatelessWidget {
  const Immatriculation({Key key, this.infomodel})
      : super(key: key);
  final InfoModel infomodel;
  @override
  Widget build(BuildContext context) {
     Future<void> _confirmDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, 
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
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 365,
            width: MediaQuery.of(context).size.width,
            child: Card(
              elevation: 8,
              child: Column(
                children: [
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                      infomodel.immatriculation,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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
             
               
              onPressed: () {
               _confirmDialog();
               
              },
            
              
            
              color: Color(0xFF27313B),
                iconSize: 30,
                 padding:EdgeInsets.only(bottom:50)
                
            ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}