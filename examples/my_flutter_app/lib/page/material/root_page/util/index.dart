import 'package:flutter/material.dart';
import 'package:package/index.dart';
import 'package:my_flutter_app/page/material/root_page/util/getx_util/page.dart';

class UtilRootPage extends StatefulWidget {
  const UtilRootPage({super.key});

  @override
  State<UtilRootPage> createState() => _UtilRootPageState();
}

class _UtilRootPageState extends State<UtilRootPage> {
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    List<NavPageModel> utilCellItems = [
      NavPageModel('Getx工具类测试', GetxUtilPage()),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('工具列表'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildListSection(context, '工具类测试', utilCellItems),
          ],
        ),
      ),
    );
  }
}
