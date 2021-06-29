
import 'package:changilni_user/Model/InfoModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'SuperModel.g.dart';

@JsonSerializable()
class SuperModel {
  List<InfoModel> data;
  SuperModel({this.data});
  factory SuperModel.fromJson(Map<String, dynamic> json) =>
      _$SuperModelFromJson(json);
  Map<String, dynamic> toJson() => _$SuperModelToJson(this);
}