import 'package:flutter/material.dart';

/// 构建通用的列表分割线widget
IndexedWidgetBuilder buildSeparatorWidget({
  double height = 0,
  double thickness = 0.5,
  double indent = 0,
}) {
  return (context, index) => Divider(
        height: height,
        thickness: thickness,
        indent: indent,
      );
}

Widget buildListViewDemo() {
  return ListView.builder(
    itemBuilder: (context, index) => ListTile(
      onTap: () {},
      title: Text('列表-${index + 1}'),
    ),
  );
}
