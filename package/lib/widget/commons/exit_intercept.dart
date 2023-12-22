import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../util/toast.dart';

class ExitInterceptWidget extends StatefulWidget {
  const ExitInterceptWidget({super.key, required this.child});

  final Widget child;

  @override
  State<ExitInterceptWidget> createState() => _ExitInterceptWidgetState();
}

class _ExitInterceptWidgetState extends State<ExitInterceptWidget> {
  bool allowQuit = false; // 双击返回键退出应用
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: allowQuit,
      onPopInvoked: (_) async {
        if (!allowQuit) {
          setState(() {
            allowQuit = true;
          });
          ToastUtil.showToast('请再按一次退出应用');
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
