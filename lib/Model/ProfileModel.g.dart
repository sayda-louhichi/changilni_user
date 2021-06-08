// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProfileModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) {
  return ProfileModel(
    username: json['username'] as String,
    email: json['email'] as String,
    cin: json['cin'] as String,
    tel: json['tel'] as String,
    adress: json['adress'] as String,
  );
}

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'cin': instance.cin,
      'tel': instance.tel,
      'adress': instance.adress,
    };
