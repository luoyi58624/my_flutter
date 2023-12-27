import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/my_flutter.dart';
import 'dart:io';

/// 图片组件，统一项目中的用法
class ImageWidget extends StatefulWidget {
  /// 默认图片构造器
  const ImageWidget({
    super.key,
    this.url,
    this.asset,
    this.file,
    this.width,
    this.height,
    this.radius = 6,
    this.borderRadius,
    this.fit = BoxFit.cover,
    this.heroTag,
    this.failWidget,
    this.onTap,
  })  : circleImage = false,
        size = null;

  /// 圆形图片构造器
  const ImageWidget.circle({
    super.key,
    this.url,
    this.asset,
    this.file,
    this.size = 36,
    this.heroTag,
    this.failWidget,
    this.onTap,
  })  : circleImage = true,
        fit = BoxFit.cover,
        width = null,
        height = null,
        radius = 0,
        borderRadius = null;

  /// 从网络地址加载
  final String? url;

  /// 从assets静态目录加载
  final String? asset;

  /// 从本地文件加载，提示：web平台不支持加载本地文件，所以web平台使用将使用[Placeholder]组件进行占位
  final String? file;

  /// 图片宽高
  final double? width;
  final double? height;

  /// 图片圆角
  final double radius;

  /// 自定义圆角
  final BorderRadiusGeometry? borderRadius;

  /// 圆角图片，若为true，
  final bool circleImage;

  /// 圆形图片尺寸
  final double? size;

  /// 图片展示方式，默认填充容器[BoxFit.cover]
  final BoxFit fit;

  /// hero英雄动画
  final String? heroTag;

  /// 图片加载失败时展示的widget，它会覆盖默认的失败图标
  final Widget? failWidget;

  /// 自定义点击事件，它会覆盖默认的预览行为
  final GestureTapCallback? onTap;

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  double? get width => widget.size ?? widget.width;

  double? get height => widget.size ?? widget.height;

  @override
  Widget build(BuildContext context) {
    late Widget imageWidget;
    if (!CommonUtil.isEmpty(widget.url) && Uri.tryParse(widget.url!) != null) {
      imageWidget = buildRadiusClipWidget(buildNetworkImage());
    } else if (!CommonUtil.isEmpty(widget.asset)) {
      imageWidget = buildRadiusClipWidget(buildAssetImage());
    } else if (!CommonUtil.isEmpty(widget.file)) {
      imageWidget = buildRadiusClipWidget(buildFileImage());
    } else {
      imageWidget = loadFailWidget;
    }
    return GestureDetector(
      onTap: widget.onTap,
      child: imageWidget,
    );
  }

  Widget buildRadiusClipWidget(Widget child) {
    late BorderRadiusGeometry borderRadius;
    if (widget.circleImage) {
      borderRadius = BorderRadius.circular(widget.size! / 2);
    } else {
      borderRadius = widget.borderRadius ?? BorderRadius.circular(widget.radius);
    }
    return ClipRRect(
      borderRadius: borderRadius,
      child: child,
    );
  }

  Widget buildNetworkImage() {
    return CachedNetworkImage(
      imageUrl: widget.url!,
      width: width,
      height: height,
      fit: widget.fit,
      placeholder: (context, url) => SpinKitPulse(color: Colors.grey.shade400),
      errorWidget: (context, url, error) => loadFailWidget,
    );
  }

  Widget buildAssetImage() {
    return Image.asset(
      widget.asset!,
      width: width,
      height: height,
      fit: widget.fit,
    );
  }

  Widget buildFileImage() {
    if (kIsWeb) {
      return widget.circleImage
          ? Container(
              width: widget.size ?? widget.width,
              height: widget.size ?? widget.height,
              color: Colors.grey,
            )
          : SizedBox(
              width: width,
              height: height,
              child: const Placeholder(),
            );
    } else {
      return Image.file(
        File(widget.file!),
        width: width,
        height: height,
        fit: widget.fit,
      );
    }
  }

  Widget get loadFailWidget {
    return SizedBox(
      width: width,
      height: height,
      child: widget.failWidget == null
          ? const Icon(
              Icons.error_outline_outlined,
            )
          : widget.failWidget!,
    );
  }
}
