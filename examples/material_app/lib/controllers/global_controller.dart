import 'package:flutter/material.dart';
import 'package:my_flutter/my_flutter.dart';

class GlobalController extends GetxController {
  final RxBool useMaterial3 = false.obs; // 使用material3风格
  final RxBool isDark = false.obs; // 开启黑暗模式

  ThemeData get appTheme {
    return isDark.value ? ThemeData.dark() : ThemeData.light();
  }

  @override
  void onInit() {
    super.onInit();

    useMaterial3.value = localStorage.getItem('useMaterial3', false);
    isDark.value = localStorage.getItem('isDark', false);
    useMaterial3.listen((value) {
      localStorage.setItem('useMaterial3', value);
    });
    isDark.listen((value) {
      localStorage.setItem('isDark', value);
    });
  }
}
