import 'package:logger/logger.dart';

var _logger = Logger(
  printer: PrettyPrinter(
    methodCount: 1,
    errorMethodCount: 2,
    printEmojis: false,
    noBoxingByDefault: false,
  ),
);

/// 打印日志工具类
class LoggerUtil {
  LoggerUtil._();

  static void d(dynamic message, [String? title]) {
    _logger.d(message, error: title);
  }

  static void i(dynamic message, [String? title]) {
    _logger.i(message, error: title);
  }

  static void w(dynamic message, [String? title]) {
    _logger.w(message, error: title);
  }

  static void e(dynamic message, [String? title]) {
    _logger.w(message, error: title);
  }
}
