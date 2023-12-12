import 'package:flutter/widgets.dart';

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

class NavPageModel {
  final String title;
  final Widget widget;
  final IconData? icon;

  const NavPageModel(this.title, this.widget, {this.icon});
}
