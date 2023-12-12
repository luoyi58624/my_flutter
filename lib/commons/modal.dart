import 'package:flutter/widgets.dart';

class LabelModel {
  final String label;
  final String value;

  LabelModel(this.label, this.value);
}

class ListTilePageModel {
  final String title;
  final Widget widget;
  final IconData? icon;

  const ListTilePageModel(this.title, this.widget, {this.icon});
}

class RootPageModel {
  final String title;
  final Widget widget;
  final IconData icon;

  const RootPageModel(this.title, this.widget, this.icon);
}
