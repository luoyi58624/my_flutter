import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/modal.dart';
import '../../util/router.dart';

/// 构建通用分割线Widget
Widget buildDividerWidget({
  double height = 0,
  double thickness = 0.5,
  double indent = 0,
}) {
  return Divider(
    height: height,
    thickness: thickness,
    indent: indent,
  );
}

/// 构建通用的列表分割线widget
IndexedWidgetBuilder buildSeparatorWidget({
  double height = 0,
  double thickness = 0.5,
  double indent = 0,
}) {
  return (context, index) => buildDividerWidget(
        height: height,
        thickness: thickness,
        indent: indent,
      );
}

Widget buildListViewDemo() {
  return ListView.builder(
    // itemExtentBuilder: ,
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
        child: Text('重启App'),
      ),
    ],
  );
}

Widget buildCenterColumn(List<Widget> children) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: children,
    ),
  );
}

Widget buildListSection(BuildContext context, String title, List<NavPageModel> cellItems) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      _buildCell(context, cellItems)
    ],
  );
}

Widget _buildCell(BuildContext context, List<NavPageModel> cellItems) {
  return Column(
    children: cellItems
        .map(
          (e) => Column(
            children: [
              ListTile(
                title: Text(e.title),
                trailing: const Icon(Icons.keyboard_arrow_right_outlined),
                onTap: () {
                  RouterUtil.to(e.page);
                },
              ),
              buildDividerWidget(),
            ],
          ),
        )
        .toList(),
  );
}
//
// Widget buildCupertinoScrollbar(){
//
// }

/// 构建ios滚动条，如果是桌面端(包括桌面端web)，则不使用ios滚动条，因为会冲突
Widget buildCupertinoScrollbar({
  required Widget child,
  ScrollController? controller,
  bool thumbVisibility = false, // 是否一直显示滚动条
}) {
  if (GetPlatform.isDesktop) {
    return child;
  } else {
    return CupertinoScrollbar(
      controller: controller,
      thumbVisibility: thumbVisibility,
      child: child,
    );
  }
}
