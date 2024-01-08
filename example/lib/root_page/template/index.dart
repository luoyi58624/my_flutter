import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../plugins.dart';
import 'child.dart';

class TemplateRootPage extends StatefulWidget {
  const TemplateRootPage({super.key});

  @override
  State<TemplateRootPage> createState() => TemplateRootPageState();
}

class TemplateRootPageState extends State<TemplateRootPage> {
  int count = 0;

  void addCount() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // LoggerUtil.i('build');
    LoggerUtil.i(GetPlatform.isDesktop);
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          const ExtendedCupertinoSliverNavigationBar(
            largeTitle: Text(
              '模板列表',
            ),
          ),
          SliverToBoxAdapter(
            child: fontDemo,
          )
        ],
      ),
    );
  }

  Widget get fontDemo => buildCenterColumn([
        ElevatedButton(
          onPressed: () {
            RouterUtil.to(const TemaplteChildPage());
          },
          child: const Text('下一页'),
        ),
        ElevatedButton(
          onPressed: () {
            RouterUtil.to(const TemaplteChildPage2());
          },
          child: const Text('下一页2'),
        ),
        ElevatedButton(
          onPressed: () {
            RouterUtil.to(const TemplateChildPage3());
          },
          child: const Text('下一页3'),
        ),
        const Text(
          '西那卡塞吸机你显卡xanjsxnkjasnxkjansxk行啊就开心阿珂',
          style: TextStyle(
            fontWeight: FontWeight.w100,
          ),
        ),
        const Text(
          '西那卡塞吸机你显卡xanjsxnkjasnxkjansxk行啊就开心阿珂',
          style: TextStyle(
            fontWeight: FontWeight.w200,
          ),
        ),
        const Text(
          '西那卡塞吸机你显卡xanjsxnkjasnxkjansxk行啊就开心阿珂',
          style: TextStyle(
            fontWeight: FontWeight.w300,
          ),
        ),
        const Text(
          '西那卡塞吸机你显卡xanjsxnkjasnxkjansxk行啊就开心阿珂',
          style: TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
        const Text(
          '西那卡塞吸机你显卡xanjsxnkjasnxkjansxk行啊就开心阿珂',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        const Text(
          '西那卡塞吸机你显卡xanjsxnkjasnxkjansxk行啊就开心阿珂',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        const Text(
          '西那卡塞吸机你显卡xanjsxnkjasnxkjansxk行啊就开心阿珂',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        const Text(
          '西那卡塞吸机你显卡xanjsxnkjasnxkjansxk行啊就开心阿珂',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        const Text(
          '西那卡塞吸机你显卡xanjsxnkjasnxkjansxk行啊就开心阿珂',
          style: TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
      ]);
}
