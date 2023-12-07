import 'package:flutter/cupertino.dart';
import 'package:my_flutter/my_flutter.dart';

import 'button.dart';
import 'switch.dart';

class ComponentRootPage extends StatefulWidget {
  const ComponentRootPage({super.key});

  @override
  State<ComponentRootPage> createState() => _ComponentRootPageState();
}

class _ComponentRootPageState extends State<ComponentRootPage> {
  @override
  Widget build(BuildContext context) {
    List<ListTilePageModel> listData = const [
      ListTilePageModel('Button 按钮', ButtonPage('Button 按钮')),
      ListTilePageModel('Switch 开关', SwitchPage('Switch 开关')),
      ListTilePageModel('Slider 滑块', SwitchPage('Slider 滑块')),
      ListTilePageModel('Loading 加载指示器', SwitchPage('Loading 加载指示器')),
      ListTilePageModel('Picker 选择器', SwitchPage('Picker 选择器')),
      ListTilePageModel('TimePicker 时间选择器', SwitchPage('TimePicker 时间选择器')),
      ListTilePageModel('DatePicker 日期选择器', SwitchPage('DatePicker 日期选择器')),
      ListTilePageModel('TextField 文本框', SwitchPage('TextField 文本框')),
      ListTilePageModel('Search 搜索框', SwitchPage('Search 搜索框')),
      ListTilePageModel('ListGroup 列表组', SwitchPage('ListGroup 列表组')),
      ListTilePageModel('ActionSheet 底部弹出选项', SwitchPage('ActionSheet 底部弹出选项')),
      ListTilePageModel('AlertDialog 警告弹窗', SwitchPage('AlertDialog 警告弹窗')),
      ListTilePageModel('ContextMenu 长按右键菜单', SwitchPage('ContextMenu 长按右键菜单')),
      ListTilePageModel('Segmented 分段选择器', SwitchPage('Segmented 分段选择器')),
    ];
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(largeTitle: Text('组件列表')),
          SliverList.builder(
            itemCount: listData.length,
            itemBuilder: (context, index) => MyCupertinoListTile(
              title: listData[index].title,
              page: listData[index].widget,
            ),
          ),
        ],
      ),
    );
  }
}
