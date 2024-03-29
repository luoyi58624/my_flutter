import 'package:flutter/material.dart';

import 'tap_animate.dart';

/// 通用标签widget
class TagWidget extends StatelessWidget {
  /// 边框tag
  const TagWidget(
    this.text,
    this.color, {
    super.key,
    this.onTap,
    this.padding,
    this.width,
    this.height,
    this.fill = false,
  });

  final double? width;
  final double? height;
  final String text;
  final Color color;
  final bool fill;
  final EdgeInsetsGeometry? padding;
  final void Function()? onTap; // 点击回调

  @override
  Widget build(BuildContext context) {
    return TapScaleWidget(
      onTap: onTap,
      scale: 0.90,
      child: Container(
        width: width,
        height: height,
        padding: padding ??
            EdgeInsets.symmetric(
              vertical: height == null ? 3 : 0,
              horizontal: width == null ? 8 : 0,
            ),
        decoration: BoxDecoration(
          color: fill ? color : color.withAlpha(10),
          borderRadius: BorderRadius.circular(2),
          border: fill
              ? Border.all(color: Colors.transparent, width: 1)
              : Border.all(color: color, width: 1),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: fill ? Colors.white : color,
              fontSize: 12,
            ),
            strutStyle: const StrutStyle(
              forceStrutHeight: true,
            ),
          ),
        ),
      ),
    );
  }
}
