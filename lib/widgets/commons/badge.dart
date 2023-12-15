import 'package:flutter/material.dart';
import 'package:my_flutter/my_flutter.dart';

class BadgeWidget extends StatelessWidget {
  const BadgeWidget({
    Key? key,
    required this.child,
    required this.bagde,
    this.color,
    this.max = 99,
    this.hideZero = true,
    this.offset,
  }) : super(key: key);

  final Widget child;
  final dynamic bagde; // 徽章内容，支持字符串和数字
  final Color? color; // 徽章颜色，默认为红色
  final int max; // 限制显示的最大值，超出此数后面追加+
  final bool hideZero; // 当值小于等于0时，是否将其隐藏
  final Offset? offset;

  @override
  Widget build(BuildContext context) {
    if (CommonUtil.isEmpty(bagde)) {
      return child;
    }
    if (bagde is num) {
      return Badge(
        label: Container(
          constraints: const BoxConstraints(minWidth: 16),
          child: Center(
            child: Text(bagde > max ? '$max+' : bagde.toString()),
          ),
        ),
        isLabelVisible: hideZero ? bagde > 0 : true,
        padding: badgePadding,
        backgroundColor: color ?? Colors.red,
        textColor: Colors.white,
        textStyle: textStyle,
        offset: offset,
        child: child,
      );
    } else {
      return Badge(
        label: Text(bagde),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        backgroundColor: color ?? Colors.red,
        textColor: Colors.white,
        textStyle: textStyle,
        offset: offset,
        child: child,
      );
    }
  }

  TextStyle get textStyle => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      );

  /// 让徽章填充样式更加好看，默认情况下徽章给人的感官没有对齐
  EdgeInsetsGeometry get badgePadding {
    if (bagde < 10) {
      return const EdgeInsets.symmetric(horizontal: 1);
    } else {
      return const EdgeInsets.symmetric(horizontal: 4);
    }
  }
}
