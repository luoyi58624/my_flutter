import 'dart:io';
import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:package/index.dart';

/// 封装通用的图片组件，统一项目中的用法
class ImageWidget2 extends StatefulWidget {
  /// 默认图片组件构造器
  const ImageWidget2({
    super.key,
    this.url,
    this.asset,
    this.file,
    this.memory,
    this.width = 64,
    this.height = 64,
    this.radius = 6,
    this.borderRadius,
    this.cache = true,
    this.allowReloadImage = true,
    this.fit = BoxFit.cover,
    this.heroTag,
    this.defaultWidget,
    this.failWidget,
    this.stackWidget,
    this.onReloadImage,
    this.onTap,
    this.onPreviewCallback,
    this.onErrorCallback,
  });

  /// 不限制图片宽高
  const ImageWidget2.noLimit({
    super.key,
    this.url,
    this.asset,
    this.file,
    this.memory,
    this.width,
    this.height,
    this.radius = 6,
    this.borderRadius,
    this.cache = true,
    this.allowReloadImage = true,
    this.fit = BoxFit.cover,
    this.heroTag,
    this.defaultWidget,
    this.failWidget,
    this.stackWidget,
    this.onReloadImage,
    this.onTap,
    this.onPreviewCallback,
    this.onErrorCallback,
  });

  /// 从网络地址加载
  final String? url;

  /// 从assets静态目录加载
  final String? asset;

  /// 从本地文件加载
  final String? file;

  /// 从内存中加载
  final Uint8List? memory;

  final double? width;
  final double? height;

  /// 图片圆角，默认4
  final double radius;

  /// 自定义圆角
  final BorderRadiusGeometry? borderRadius;

  /// 是否缓存图片
  final bool cache;

  /// 图片展示方式，默认填充容器
  final BoxFit fit;

  /// 当图片加载失败时是否允许点击重新加载图片，默认true
  final bool allowReloadImage;

  /// hero英雄动画
  final String? heroTag;

  /// 传入的url、asset、file为空时展示的默认widget占位
  final Widget? defaultWidget;

  /// 图片加载失败时展示的widget，它会覆盖默认的失败图标
  final Widget? failWidget;

  /// 悬浮于图片上的widget，注意：只有当图片加载成功时才有效
  final Widget? stackWidget;

  /// 当图片加载失败时，自定义重新加载图片函数
  final void Function(ExtendedImageState? imageState)? onReloadImage;

  /// 自定义点击事件，它会覆盖默认的预览行为
  final GestureTapCallback? onTap;

  /// 跳转预览页面附带执行的回调函数
  final void Function()? onPreviewCallback;

  /// 图片加载错误回调
  final void Function()? onErrorCallback;

  @override
  State<ImageWidget2> createState() => _ImageWidget2State();
}

class _ImageWidget2State extends State<ImageWidget2> {
  ExtendedImageState? imageState;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(widget.radius),
        ),
        child: buildImage(),
      ),
    );
  }

  Widget buildImage() {
    if (widget.url != null) {
      return buildNetworkImage();
    } else if (widget.asset != null) {
      return buildAssetImage();
    } else if (widget.file != null) {
      return buildFileImage();
    } else if (widget.memory != null) {
      return buildMemoryImage();
    } else {
      return Center(
        child: widget.defaultWidget,
      );
    }
  }

  bool get showLoading {
    if (widget.url != null || widget.file != null) {
      return true;
    } else {
      return false;
    }
  }

  Widget buildNetworkImage() {
    if (!CommonUtil.isEmpty(widget.url) && Uri.tryParse(widget.url!) != null) {
      return ExtendedImage.network(
        widget.url!,
        cache: widget.cache,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        retries: 3,
        gaplessPlayback: true,
        enableLoadState: true,
        clearMemoryCacheIfFailed: true,
        loadStateChanged: (state) {
          return imageLoadStatus(state);
        },
      );
    } else {
      return loadFailWidget;
    }
  }

  Widget buildAssetImage() {
    return ExtendedImage.asset(
      widget.asset!,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      gaplessPlayback: true,
      enableLoadState: false,
      clearMemoryCacheIfFailed: true,
      loadStateChanged: (state) {
        return imageLoadStatus(state);
      },
    );
  }

  Widget buildFileImage() {
    return ExtendedImage.file(
      File(widget.file!),
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      gaplessPlayback: true,
      enableLoadState: false,
      clearMemoryCacheIfFailed: true,
      loadStateChanged: (state) {
        return imageLoadStatus(state);
      },
    );
  }

  Widget buildMemoryImage() {
    return ExtendedImage.memory(
      widget.memory!,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      gaplessPlayback: true,
      enableLoadState: false,
      clearMemoryCacheIfFailed: true,
      loadStateChanged: (state) {
        return imageLoadStatus(state);
      },
    );
  }

  /// 网络图片加载时的widget
  Widget? imageLoadStatus(ExtendedImageState state) {
    imageState = state;
    switch (state.extendedImageLoadState) {
      case LoadState.loading:
        return loadLoadingWidget;
      case LoadState.failed:
        if (widget.onErrorCallback != null) {
          Future.delayed(const Duration(milliseconds: 300), () {
            widget.onErrorCallback!();
          });
        }
        return GestureDetector(
          onTap: () {
            if (widget.allowReloadImage) {
              if (widget.onReloadImage == null) {
                imageState?.reLoadImage();
              } else {
                widget.onReloadImage!(imageState);
              }
            }
          },
          child: loadFailWidget,
        );
      case LoadState.completed:
        if (widget.stackWidget == null) {
          return state.completedWidget;
        } else {
          return Stack(
            children: [
              state.completedWidget,
              widget.stackWidget!,
            ],
          );
        }
      default:
        return null;
    }
  }

  double get width => widget.width ?? 64.0;

  Widget? get loadLoadingWidget {
    return showLoading
        ? SpinKitPulse(
            color: ThemeController.of.infoColor.value,
            size: width / 5 * 3,
          )
        : null;
  }

  Widget get loadFailWidget {
    if (widget.failWidget != null) {
      return widget.failWidget!;
    } else {
      return Icon(
        Icons.error_outline_outlined,
        size: width / 2,
      );
    }
  }
}
