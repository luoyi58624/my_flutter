import 'package:my_flutter/my_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionUtil {
  PermissionUtil._();

  /// 请求权限，对 permission_handler 进行一个简单的封装
  static Future<bool> requestPermission(Permission permission) async {
    // 先获取权限状态
    PermissionStatus status = await permission.status;
    if (status.isGranted) {
      return true;
    } else {
      // 请求权限
      PermissionStatus requestStatus = await permission.request();
      // 如果授权则返回true，否则
      if (requestStatus.isGranted) {
        return true;
      } else if (requestStatus.isDenied) {
        ToastUtil.showToast('您拒绝了权限');
        return false;
      } else if (requestStatus.isPermanentlyDenied) {
        // _showModal();
        return false;
      } else {
        return false;
      }
    }
  }

  /// 请求权限，对 permission_handler 进行一个简单的封装
  static Future<bool> hasPermission(Permission permission) async {
    // 先获取权限状态
    PermissionStatus status = await permission.status;
    if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  // static void _showModal() {
  //   ModalUtils.showConfitmModal(
  //     title: '警告',
  //     content: '你需要跳转到手机设置手动开启权限！',
  //     cancelText: '取消',
  //     confirmText: '跳转设置',
  //     onConfirm: () {
  //       openAppSettings();
  //     },
  //   );
  // }
}
