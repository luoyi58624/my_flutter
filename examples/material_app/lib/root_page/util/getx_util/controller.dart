import 'dart:convert';

import 'package:my_flutter/my_flutter.dart';

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

class GetxUtilController extends GetxController {
  final count = useLocalObs(0, 'count');
  final userModel = useLocalObs(
    UserModel(),
    'userModel',
    serializeFun: (value) => jsonEncode(value.toJson()),
    deserializeFun: (value) => UserModel.fromJson(jsonDecode(value)),
  );
}
