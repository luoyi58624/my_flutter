import 'package:my_flutter/common/index.dart';

class UserModel extends SerializeModel {
  String? username;
  num? password;

  UserModel(this.username, this.password);

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'] ?? '';
    password = json['password'] ?? 0;
  }

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    return data;
  }

  @override
  T fromJson<T>(Map<String, dynamic> json) {
    return UserModel.fromJson(json) as T;
  }
}
