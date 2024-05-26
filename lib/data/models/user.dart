import 'dart:convert';
import 'package:pos/domain/entities/entities.dart';

class UserModel {
  String name;
  String email;
  String uid;
  String profileURL;

  UserModel({
    required this.name,
    required this.email,
    required this.uid,
    required this.profileURL
  });

  factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    name: json["name"],
    email: json["email"],
    uid: json["uid"],
    profileURL: json["profileURL"]
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "uid": uid,
    "profileURL": profileURL
  };

  factory UserModel.fromEntity(UserEntity data) => UserModel(
    name: data.name,
    email: data.email,
    uid: data.uid,
    profileURL: data.profileURL
  );

  UserEntity toEntity() => UserEntity(
      name: name,
      email: email,
      uid: uid,
      profileURL: profileURL
  );

}