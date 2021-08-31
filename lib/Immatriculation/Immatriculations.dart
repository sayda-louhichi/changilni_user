import 'package:changilni_user/CustumWidget/ImmatriculationCard.dart';
import 'package:changilni_user/Immatriculation/Immatriculation.dart';
import 'package:changilni_user/Model/InfoModel.dart';
import 'package:changilni_user/Model/SuperModel.dart';
import 'package:flutter/material.dart';

import '../NetworkHandler.dart';

class Immatriculations extends StatefulWidget {
  Immatriculations({Key key, this.url}) : super(key: key);
  final String url;

  @override
  _ImmatriculationsState createState() => _ImmatriculationsState();
}

class _ImmatriculationsState extends State<Immatriculations> {
  NetworkHandler networkHandler = NetworkHandler();
  SuperModel superModel = SuperModel();
  List<InfoModel> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
   var response = await networkHandler.get(widget.url);
    superModel = SuperModel.fromJson(response);
    setState(() {
      data = superModel.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return data.length > 0
        ? Column(
            children: data
                .map((item) => Column(
                      children: <Widget>[
                        InkWell(
                         onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (contex) => Immatriculation(
                                          infomodel: item,
                                        )
                                        )
                                        );
                          },
                          child: ImmatriculationCard(
                            infomodel: item,
                          ),
                        ),
                      ],
                    ))
                .toList(),
          )
        : Center(
            child: Text("We don't have any Blog Yet"),
          );
  }
}