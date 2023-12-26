import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../util/toast.dart';

class ExitInterceptWidget extends StatefulWidget {
  /// 拦截用户退出应用
  const ExitInterceptWidget({super.key, required this.child, this.message = '请再按一次退出应用'});

  final Widget child;

  final String message;

  @override
  State<ExitInterceptWidget> createState() => _ExitInterceptWidgetState();
}

class _ExitInterceptWidgetState extends State<ExitInterceptWidget> {
  bool allowQuit = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: allowQuit,
      onPopInvoked: (_) async {
        if (!allowQuit) {
          setState(() {
            allowQuit = true;
          });
          ToastUtil.showToast(widget.message);
          Timer(const Duration(seconds: 2), () {
            if (mounted) {
              setState(() {
                allowQuit = false;
              });
            }
          });
        }
      },
      child: widget.child,
    );
  }
}
