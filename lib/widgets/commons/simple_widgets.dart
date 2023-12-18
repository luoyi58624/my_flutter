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

Widget buildPopupMenuButton({
  Offset? offset,
}) {
  return PopupMenuButton(
    elevation: 2,
    offset: const Offset(0, 50),
    padding: const EdgeInsets.all(0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
    ),
    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
      const PopupMenuItem(
        child: Text('MaterialApp'),
      ),
      const PopupMenuItem(
        child: Text('CupertinoApp'),
      ),
      const PopupMenuItem(
        child: Text(
            '重启App                                                                                   '),
      ),
    ],
  );
}
