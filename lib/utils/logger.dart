import 'package:logger/logger.dart';

/// 打印日志
var logger = Logger(
  printer: PrettyPrinter(
    methodCount: 1,
    errorMethodCount: 2,
    printEmojis: false,
    noBoxingByDefault: false,
  ),
);
