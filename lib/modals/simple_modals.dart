import 'package:flutter/widgets.dart';

/// 包含label-value结构的简单数据模型
class LabelModel {
  final String label;
  final String value;

  LabelModel(this.label, this.value);
}

class RootPageModel {
  final String label;
  final IconData icon;
  final Widget page;

  const RootPageModel(this.label, this.icon, this.page);
}
