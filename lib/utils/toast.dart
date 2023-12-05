import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

FToast toast = FToast();

/// 轻提示工具类
class ToastUtils {
  static final ToastUtils _instance = ToastUtils._();

  factory ToastUtils() => _instance;

  ToastUtils._();

  /// 构建一个自定义widget的toast，如果当前页面已经有一个toast，则会关闭它重新显示新的toast
  void _buildToast(Widget toastWidget, int duration) {
    toast.removeCustomToast();
    toast.showToast(
      child: toastWidget,
      toastDuration: Duration(seconds: duration),
      gravity: ToastGravity.CENTER,
    );
  }

  /// 显示通用风格的轻提示，它会自动适配黑暗模式
  static void showToast(dynamic title, {int duration = 3}) {
    ToastUtils()._buildToast(_ToastWidget(title: title), duration);
  }
}

/// 自定义Toast组件
class _ToastWidget extends StatelessWidget {
  const _ToastWidget({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        toast.removeCustomToast();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(0, 0, 0, 0.8),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: CupertinoColors.white,
          ),
        ),
      ),
    );
  }
}
