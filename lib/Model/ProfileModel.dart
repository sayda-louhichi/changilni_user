import 'package:json_annotation/json_annotation.dart';

part 'ProfileModel.g.dart';

@JsonSerializable()
class ProfileModel {
 
  String username;
  String email;
  String cin;
  String tel;
  String adress;
  ProfileModel(
      {this.username,
      this.email,
      this.cin,
      this.tel,
      this.adress});

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}