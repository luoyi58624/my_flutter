import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:package/index.dart';

/// 图片组件，统一项目中的用法
class ImageWidget extends StatefulWidget {
  /// 默认图片构造器，它无法渲染完整的圆角，若你需要圆角请使用circle构造器，它将使用CircleAvatar组件进行渲染
  const ImageWidget(
    this.url, {
    super.key,
    this.width,
    this.height,
    this.size,
    this.radius = 6,
    this.borderRadius,
    this.fit = BoxFit.cover,
    this.heroTag,
    this.failWidget,
    this.onTap,
  }) : circleImage = false;

  /// 圆形图片构造器
  const ImageWidget.circle(
    this.url,
    this.size, {
    super.key,
    this.fit = BoxFit.cover,
    this.heroTag,
    this.failWidget,
    this.onTap,
  })  : circleImage = true,
        width = null,
        height = null,
        radius = 0,
        borderRadius = null;

  /// 图片地址，如果是http开头的将从网络地址加载，否则将加载assets中的图片。
  ///
  /// 提示：如果你需要从本地加载图片，那你将会用到io包，若你用了io包将不再支持web。
  final String url;

  /// 图片尺寸，它将取代宽高属性，强制宽高一致
  final double? size;

  /// 限制图片宽高
  final double? width;
  final double? height;

  /// 图片圆角
  final double radius;

  /// 自定义圆角
  final BorderRadiusGeometry? borderRadius;

  /// 图片展示方式，默认填充容器
  final BoxFit fit;

  /// 圆形图片
  final bool circleImage;

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
  @override
  Widget build(BuildContext context) {
    late Widget imageWidget;
    if (widget.circleImage) {
      imageWidget = CircleAvatar(
        radius: widget.size! / 2,
        backgroundImage: buildImageProvider(),
      );
    } else {
      imageWidget = ClipRRect(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(widget.radius),
        child: buildNetworkImage(),
      );
    }
    return GestureDetector(
      onTap: widget.onTap,
      child: imageWidget,
    );
  }

  ImageProvider? buildImageProvider() {
    if (!CommonUtil.isEmpty(widget.url) && Uri.tryParse(widget.url) != null) {
      return CachedNetworkImageProvider(
        widget.url,
      );
    } else {
      return null;
    }
  }

  Widget buildNetworkImage() {
    if (!CommonUtil.isEmpty(widget.url) && Uri.tryParse(widget.url) != null) {
      return CachedNetworkImage(
        imageUrl: widget.url,
        width: widget.size ?? widget.width,
        height: widget.size ?? widget.height,
        fit: widget.fit,
        placeholder: (context, url) => SpinKitPulse(color: Colors.grey.shade400),
        errorWidget: (context, url, error) => loadFailWidget,
      );
    } else {
      return loadFailWidget;
    }
  }

  Widget get loadFailWidget {
    if (widget.failWidget != null) {
      return widget.failWidget!;
    } else {
      return const Icon(
        Icons.error_outline_outlined,
      );
    }
  }
}
