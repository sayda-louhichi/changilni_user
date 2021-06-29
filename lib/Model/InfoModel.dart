
import 'package:json_annotation/json_annotation.dart';


@JsonSerializable()
class InfoModel {
  String id;
  String immatriculation;
  String email;

  InfoModel({this.id, this.immatriculation, this.email});

  InfoModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    immatriculation = json['immatriculation'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['immatriculation'] = this.immatriculation;
    data['email'] = this.email;
    return data;
  }
}