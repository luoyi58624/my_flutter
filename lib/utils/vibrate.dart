import 'package:vibration/vibration.dart';

/// 震动工具类
class VibrateUtil {
  VibrateUtil._();

  /// 触发通用的震动提示
  static void vibrate({
    // 震动模式，默认：延迟150毫秒，震动250毫秒，再间隔150毫秒，震动150毫秒
    List<int> pattern = const [150, 250, 150, 200],
    // 震动幅度，值越大震动的触感也就越强烈
    int amplitude = 128,
  }) {
    Vibration.vibrate(
      pattern: pattern,
      amplitude: amplitude,
    );
  }
}
