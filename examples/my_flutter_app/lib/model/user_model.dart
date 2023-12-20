import 'dart:convert';

class UserModel {
  String? username;
  num? password;

  UserModel();

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'] ?? '';
    password = json['password'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    return data;
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}
