import '../my_flutter.dart';

/// MaterialApp控制器
class MaterialController extends GetxController {
  /// 是否默认使用material3主题
  final _useMaterial3 = useLocalObs(false, 'material3');

  MaterialController({
    bool? useMaterial3,
  }) {
    _useMaterial3.value = useMaterial3 ?? false;
  }
}
