import 'dart:async';
import 'dart:math';

import 'package:flustars/flustars.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';
import 'package:html/parser.dart' as htmlparser;

/// uuid生成实例
///
/// 示例：
/// ```dart
/// uuid.v1();  // Generate a v1 (time-based) id
/// uuid.v4();  // Generate a v4 (random) id
/// ```
const _uuid = Uuid();

/// 图片后缀
const imageSuffix = ['jpg', 'jpeg', 'png', 'gif'];

/// 静态图片图片后缀
const staticImageSuffix = ['jpg', 'jpeg', 'png'];

/// 视频后缀
const videoSuffix = ['mkv', 'mp4', 'avi', 'mov', 'wmv'];

/// 比较两个值的条件类型
enum CompareType {
  /// 小于
  less,

  /// 小于等于
  lessEqual,

  /// 等于
  equal,

  /// 大于等于
  thanEqual,

  /// 大于
  than,
}

class CommonUtil {
  CommonUtil._();

  /// 是否是苹果平台
  static bool get isApplePlatform => GetPlatform.isMacOS || GetPlatform.isIOS;

  /// 判断一个变量是否为空，例如：null、''、[]、{}
  ///
  /// checkNum - 若为true，则判断数字是否为0
  /// checkString - 若为true，则判断字符串是否为 'null'
  static bool isEmpty(
    dynamic value, {
    bool? checkNum,
    bool? checkString,
  }) {
    if (null == value) {
      return true;
    } else if (value is String) {
      var str = value.trim();
      if (checkString == true) {
        return str.isEmpty || str == 'null';
      } else {
        return str.isEmpty;
      }
    } else if (checkNum == true && value is num) {
      return value == 0;
    } else if (value is List) {
      return value.isEmpty;
    } else if (value is Map) {
      return value.isEmpty;
    } else if (value is Object) {
      return value == {};
    } else {
      return false;
    }
  }

  /// 安全解析String，如果传递的value为空，则返回一个默认值
  static String safeString(
    dynamic value, {
    String defaultValue = '',
    String? suffixText, // 字符串后缀文字 (如果返回的字符串不为空)
  }) {
    if (isEmpty(value)) {
      return defaultValue;
    } else {
      if (suffixText == null) {
        return value.toString();
      } else {
        return value.toString() + suffixText;
      }
    }
  }

  /// 安全解析int，如果传递的value不是num类型，则返回默认值
  static int safeInt(dynamic value, {int defaultValue = 0}) {
    if (value is int) {
      return value;
    } else if (value is double) {
      return int.parse(value.toString());
    } else if (value is String && int.tryParse(value) != null) {
      return int.parse(value);
    } else {
      return defaultValue;
    }
  }

  /// 安全解析double，如果传递的value不是num类型，则返回默认值
  static double safeDouble(dynamic value, {double defaultValue = 0.0}) {
    if (value is double) {
      return value;
    } else if (value is int) {
      return double.parse(value.toString());
    } else if (value is String && double.tryParse(value) != null) {
      return double.parse(value);
    } else {
      return defaultValue;
    }
  }

  /// 安全解析bool类型
  static bool safeBool(dynamic value) {
    if (value is String) {
      return bool.parse(value, caseSensitive: false);
    } else if (value is bool) {
      return value;
    } else if (value == null) {
      return false;
    } else {
      return bool.tryParse(value, caseSensitive: false) ?? false;
    }
  }

  /// 安全解析List
  static List<T> safeList<T>(dynamic value, List<T> defaultValue) {
    if (value is List) {
      return value.cast<T>();
    } else {
      return defaultValue;
    }
  }

  /// 安全解析日期，支持字符串、时间戳等格式解析，如果格式不正确则返回defaultValue，
  /// 如果defaultValue为空，则会返回当前时间。
  static DateTime safeDate(
    dynamic value, {
    dynamic defaultValue,
  }) {
    if (isEmpty(value)) {
      return _defaultDate(defaultValue);
    } else if (value is String) {
      var date = DateTime.tryParse(value);
      return date ?? _defaultDate(defaultValue);
    } else if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value);
    } else if (value is DateTime) {
      return value;
    } else {
      return _defaultDate(defaultValue);
    }
  }

  static DateTime _defaultDate(dynamic value) {
    if (isEmpty(value)) {
      return DateTime.now();
    } else if (value is String) {
      var date = DateTime.tryParse(value);
      return date ?? DateTime.now();
    } else if (value is DateTime) {
      return value;
    } else {
      return DateTime.now();
    }
  }

  /// 安全地比较两个字符
  static bool compareString(dynamic value1, dynamic value2) {
    return safeString(value1) == safeString(value2);
  }

  /// 安全地比较两个数字：小于、等于、大于、小于等于、大于等于。
  static bool compareNum(
    dynamic value1,
    dynamic value2, {
    CompareType compareType = CompareType.equal,
  }) {
    return _compareResult(compareType, safeDouble(value1) - safeDouble(value2));
  }

  /// 安全地比较两个日期，允许传入2个任意类型的数据，它们都会安全地转化为DateTime类型进行比较
  static bool compareDate(
    dynamic date1,
    dynamic date2, {
    CompareType compareType = CompareType.equal,
  }) {
    late int result; // 比较结果
    int nullValue1 = isEmpty(date1) ? 0 : 1;
    int nullValue2 = isEmpty(date2) ? 0 : 1;

    // 如果有一个值为空，则直接获取比较结果
    if (nullValue1 == 0 || nullValue2 == 0) {
      result = nullValue1 - nullValue2;
    } else {
      DateTime? dateTime1;
      DateTime? dateTime2;
      if (date1 is String) {
        dateTime1 = DateTime.tryParse(date1);
      } else if (date1 is DateTime) {
        dateTime1 = date1;
      } else {
        throw Exception('传入的date1类型错误');
      }
      if (date2 is String) {
        dateTime2 = DateTime.tryParse(date2);
      } else if (date2 is DateTime) {
        dateTime2 = date2;
      } else {
        throw Exception('传入的date2类型错误');
      }
      if (dateTime1 != null && dateTime2 != null) {
        result = dateTime1.compareTo(dateTime2);
      } else {
        result = (dateTime1 == null ? 0 : 1) - (dateTime2 == null ? 0 : 1);
      }
    }
    return _compareResult(compareType, result);
  }

  /// 比较两个日期，如果为true，则返回date1，否则返回date2。
  static DateTime getCompareDate(
    DateTime date1,
    DateTime date2, {
    CompareType compareType = CompareType.equal,
  }) {
    return compareDate(date1, date2, compareType: compareType) ? date1 : date2;
  }

  /// 获取date1和date2相差的时间，单位：毫秒
  static int diffDate(
    dynamic date1,
    dynamic date2,
  ) {
    return ((CommonUtil.safeDate(date1).millisecondsSinceEpoch -
            CommonUtil.safeDate(date2).millisecondsSinceEpoch))
        .truncate();
  }

  /// 获取date1和date2相差的天数
  static int diffDay(
    dynamic date1,
    dynamic date2,
  ) {
    return ((CommonUtil.safeDate(date1).millisecondsSinceEpoch -
                CommonUtil.safeDate(date2).millisecondsSinceEpoch) /
            1000 /
            60 /
            60 /
            24)
        .truncate();
  }

  /// 时间戳转倒计时
  static String millisecondToCountDown(int milliseconds) {
    assert(milliseconds > 0, '时间戳必须大于0');
    var duration = Duration(milliseconds: milliseconds);
    int days = duration.inDays;
    int hours = duration.inHours.remainder(24);
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);
    String hourText = hours.toString().padLeft(2, '0');
    String minuteText = minutes.toString().padLeft(2, '0');
    String secondText = seconds.toString().padLeft(2, '0');
    if (days > 0) {
      return '$days天$hourText时$minuteText分$secondText秒';
    } else if (hours > 0) {
      return '$hourText时$minuteText分$secondText秒';
    } else if (minutes > 0) {
      return '$minuteText分$secondText秒';
    } else {
      return '$secondText秒';
    }
  }

  /// 以指定格式解析日期
  static String formatDate(dynamic value,
      {String format = 'yyyy-MM-dd HH:mm:ss'}) {
    return DateUtil.formatDate(safeDate(value), format: format);
  }

  /// 获取当前时段：早上、上午、中午、下午、晚上、深夜
  static String formatTimeFrame(dynamic value) {
    int time = safeInt(formatDate(value, format: 'HH'));
    if (0 <= time && time < 6) {
      return '晚上';
    } else if (6 <= time && time < 8) {
      return '早上';
    } else if (8 <= time && time < 12) {
      return '上午';
    } else if (12 <= time && time < 14) {
      return '中午';
    } else if (14 <= time && time < 18) {
      return '下午';
    } else if (18 <= time && time < 24) {
      return '晚上';
    } else {
      return '未知';
    }
  }

  /// 仿微信格式化日期
  static String formatTimeWeixin(
    int ms, {
    int? locMs,
    String languageCode = 'en',
    bool short = false,
  }) {
    int locTimeMs = locMs ?? DateTime.now().millisecondsSinceEpoch;
    int elapsed = locTimeMs - ms;
    if (elapsed < 0) {
      return '${formatTimeFrame(ms)} ${DateUtil.formatDateMs(ms, format: 'HH:mm')}';
    }

    if (DateUtil.isToday(ms, locMs: locTimeMs)) {
      return formatTimeFrame(ms) + DateUtil.formatDateMs(ms, format: 'HH:mm');
    }

    if (DateUtil.isYesterdayByMs(ms, locTimeMs)) {
      return '${languageCode == 'zh' ? '昨天' : 'Yesterday'}  ${formatTimeFrame(ms)}${DateUtil.formatDateMs(ms, format: 'HH:mm')}';
    }

    if (DateUtil.isWeek(ms, locMs: locTimeMs)) {
      return '${DateUtil.getWeekdayByMs(ms, languageCode: languageCode, short: short)}  ${formatTimeFrame(ms)}${DateUtil.formatDateMs(ms, format: 'HH:mm')}';
    }

    if (DateUtil.yearIsEqualByMs(ms, locTimeMs)) {
      return DateUtil.formatDateMs(ms, format: 'MM-dd');
    }

    return DateUtil.formatDateMs(ms, format: 'yyyy-MM-dd');
  }

  /// 格式化大小
  static String formatSize(size) {
    if (size == null || size == '' || size == 0) {
      return '0KB';
    }
    const unitArr = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    int index;
    var srcsize = safeDouble(size);
    index = (log(srcsize) / log(1024)).floor();
    return '${(srcsize / pow(1024, index)).toStringAsFixed(2)}${unitArr[index]}';
  }

  /// 获取地址中的文件名
  static String? getUrlFileName(String? url) {
    return p.basename(url ?? '');
  }

  /// 获取地址中的文件名但不包含扩展名
  static String? getUrlFileNameNoExtension(String? url) {
    return p.basenameWithoutExtension(url ?? '');
  }

  /// 获取文件名后缀
  static String? getFileSuffix(String fileName) {
    String suffixName = p.extension(fileName);
    if (!CommonUtil.isEmpty(suffixName) && suffixName.startsWith('.')) {
      return suffixName.replaceFirst('.', '');
    } else {
      return null;
    }
  }

  /// html转纯文本
  static String htmlToText(String html) {
    final document = htmlparser.parse(html);
    return htmlparser.parse(document.body?.text).documentElement?.text ?? '';
  }

  /// 生成uuid
  static String uuid() {
    return _uuid.v4().replaceAll('-', '');
  }

  /// 判断文件名是否是图片
  static bool isImage(String fileName) {
    String? suffixName = getFileSuffix(fileName);
    return imageSuffix.contains(suffixName);
  }

  /// 判断文件名是否是静态图片
  static bool isStaticImage(String fileName) {
    String? suffixName = getFileSuffix(fileName);
    return staticImageSuffix.contains(suffixName);
  }

  /// 判断文件名是否是视频
  static bool isVideo(String fileName) {
    String? suffixName = getFileSuffix(fileName);
    return videoSuffix.contains(suffixName);
  }

  /// 判断list集合中是否包含满足某个条件的元素
  static bool listContains<E>(List<E> list, bool Function(E element) action) {
    for (var listItem in list) {
      if (action(listItem)) {
        return true;
      }
    }
    return false;
  }

  /// 计算限制后的元素尺寸，返回类似于自适应大小的图片尺寸
  static SizeModel calcConstraintsSize(
    double width,
    double height,
    double maxWidth,
    double maxHeight,
  ) {
    late double newWidth;
    late double newHeight;
    if (width > height) {
      if (width > maxWidth) {
        newWidth = maxWidth;
        double aspect = maxWidth / width;
        newHeight = (height * aspect).ceilToDouble();
      } else {
        newWidth = width;
        newHeight = height;
      }
    } else {
      if (height > maxHeight) {
        newHeight = maxHeight;
        double aspect = maxHeight / height;
        newWidth = (width * aspect).ceilToDouble();
      } else {
        newWidth = width;
        newHeight = height;
      }
    }
    return SizeModel(newWidth, newHeight);
  }

  static Timer? _timer;

  /// 节流
  static void throttle(
    Function callback, {
    int duration = 1000,
  }) {
    if (_timer != null) {
      return;
    }

    _timer = Timer(
      Duration(milliseconds: duration),
      () {
        _timer = null;
      },
    );
    callback();
  }

  /// 判断Getx控制器是否有加载
  static bool isLoadGetxController<C extends GetxController>() {
    try {
      Get.find<C>();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 隐藏手机软键盘但保留焦点
  static Future<void> hideKeybord() async {
    await SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  /// 显示手机软键盘
  static Future<void> showKeybord() async {
    await SystemChannels.textInput.invokeMethod('TextInput.show');
  }

  /// 隐藏手机软键盘并失去焦点
  static Future<void> unfocus() async {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  /// 循环获取列表的内容，如果其索引大于列表的长度，则重头开始继续获取
  static T loopGetListContent<T>(List<T> list, int index) {
    if (index <= 0) {
      return list[0];
    } else if (index < list.length) {
      return list[index];
    } else {
      return loopGetListContent(list, index - list.length);
    }
  }

  /// 检查当前所处的组件是否包含某个祖先widget
  static bool hasAncestorElements<T>(BuildContext context) {
    bool flag = false;
    context.visitAncestorElements((element) {
      if (element.widget is T) {
        flag = true;
        return false;
      }
      return true;
    });
    return flag;
  }
}

bool _compareResult(CompareType compareType, num result) {
  switch (compareType) {
    case CompareType.equal:
      return result == 0;
    case CompareType.less:
      return result < 0;
    case CompareType.lessEqual:
      return result <= 0;
    case CompareType.than:
      return result > 0;
    case CompareType.thanEqual:
      return result >= 0;
  }
}

class SizeModel {
  final double width;
  final double height;

  SizeModel(this.width, this.height);

  @override
  String toString() {
    return 'SizeModel{width: $width, height: $height}';
  }
}
