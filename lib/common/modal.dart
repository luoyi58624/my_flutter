import 'dart:convert';

import 'package:flutter/widgets.dart';

abstract class SerializeModel {
  // SerializeModel();

  // SerializeModel.formJson(Map<String, dynamic> json);

  T fromJson<T>(Map<String, dynamic> json);

  Map<String, dynamic> toJson();

  @override
  String toString() {
    return jsonEncode(this);
  }
}

/// 包含label-value结构的简单数据模型
class LabelModel {
  final String label;
  final String value;

  LabelModel(this.label, this.value);
}

/// 包含name-icon结构的简单数据模型
class IconModel {
  final String name;
  final IconData icon;

  IconModel(this.name, this.icon);
}

/// 通用的导航页面模型，由导航标题、跳转的页面、可选图标组成
class NavPageModel {
  final String title;
  final Widget page;
  final IconData? icon;

  const NavPageModel(this.title, this.page, {this.icon});
}

/// 根页面模型
class RootPageModel extends NavPageModel {
  /// 跳转地址
  final String path;

  const RootPageModel(super.title, this.path, super.page, {super.icon});
}
