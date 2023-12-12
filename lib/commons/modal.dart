import 'package:flutter/widgets.dart';

class LabelModel {
  final String label;
  final String value;

  LabelModel(this.label, this.value);
}

class NavPageModel {
  final String title;
  final Widget widget;
  final IconData? icon;

  const NavPageModel(this.title, this.widget, {this.icon});
}
