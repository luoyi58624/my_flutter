import 'package:flutter/material.dart';
import 'package:my_flutter/my_flutter.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('模版列表'),
      ),
      body: buildCenterColumn([
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
      ]),
    );
  }
}
