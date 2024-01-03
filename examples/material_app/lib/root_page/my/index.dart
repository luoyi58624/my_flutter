import 'package:flutter/cupertino.dart';
import 'package:my_flutter/my_flutter.dart';

import 'button.dart';
import 'switch.dart';

class MyRootPage extends StatelessWidget {
  const MyRootPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<NavPageModel> listData = const [
      NavPageModel('Button 按钮', ButtonPage('Button 按钮')),
      NavPageModel('Switch 开关', SwitchPage('Switch 开关')),
      NavPageModel('Slider 滑块', SwitchPage('Slider 滑块')),
      NavPageModel('Loading 加载指示器', SwitchPage('Loading 加载指示器')),
      NavPageModel('Picker 选择器', SwitchPage('Picker 选择器')),
      NavPageModel('TimePicker 时间选择器', SwitchPage('TimePicker 时间选择器')),
      NavPageModel('DatePicker 日期选择器', SwitchPage('DatePicker 日期选择器')),
      NavPageModel('TextField 文本框', SwitchPage('TextField 文本框')),
      NavPageModel('Search 搜索框', SwitchPage('Search 搜索框')),
      NavPageModel('ListGroup 列表组', SwitchPage('ListGroup 列表组')),
      NavPageModel('ActionSheet 底部弹出选项', SwitchPage('ActionSheet 底部弹出选项')),
      NavPageModel('AlertDialog 警告弹窗', SwitchPage('AlertDialog 警告弹窗')),
      NavPageModel('ContextMenu 长按右键菜单', SwitchPage('ContextMenu 长按右键菜单')),
      NavPageModel('Segmented 分段选择器', SwitchPage('Segmented 分段选择器')),
    ];
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text('个人中心'),
          ),
          SliverList.builder(
            itemCount: listData.length,
            itemBuilder: (context, index) => MyCupertinoListTile(
              title: listData[index].title,
              page: listData[index].page,
            ),
          ),
        ],
      ),
    );
  }
}
