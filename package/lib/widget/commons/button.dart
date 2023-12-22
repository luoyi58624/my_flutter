import 'package:flutter/cupertino.dart';

class MyButton extends StatefulWidget {
  const MyButton(
    this.text, {
    super.key,
    this.asyncLoading = false,
    this.onTap,
  });

  /// 按钮文字
  final String text;

  /// 是否显示异步loading，当你执行异步函数时，按钮会禁用，并显示loading状态
  final bool asyncLoading;

  /// 按钮点击事件
  final GestureTapCallback? onTap;

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {},
      child: Text(widget.text),
    );
  }
}
