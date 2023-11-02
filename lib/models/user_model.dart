import 'dart:convert';

class UserModel {
  String? uid;

  UserModel({
    this.uid,
  });

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        uid: json["uid"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
      };
}
