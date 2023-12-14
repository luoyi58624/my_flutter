import 'package:flutter/cupertino.dart';

/// cupertino的菊花loading
Widget loadingWidget(
  double radius, {
  bool animating = true,
  Color? color,
}) =>
    CupertinoActivityIndicator(
      animating: animating,
      radius: radius,
      color: color,
    );

const Widget loadingWidget1 = CupertinoActivityIndicator(
  animating: true,
  radius: 8,
);

const Widget loadingWidget2 = CupertinoActivityIndicator(
  animating: true,
  radius: 12,
);

const Widget loadingWidget3 = CupertinoActivityIndicator(
  animating: true,
  radius: 16,
);

const Widget loadingWidget4 = CupertinoActivityIndicator(
  animating: true,
  radius: 20,
);

const Widget loadingWidget5 = CupertinoActivityIndicator(
  animating: true,
  radius: 24,
);
