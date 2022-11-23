/* Created By: Amjad Jamali on 22-Nov-2022 */

import 'package:permission_handler/permission_handler.dart';

class PermissionUtils{


  Future<bool> hasSmsPermission() async {
    return await Permission.sms.isGranted;
  }

  Future<bool> requestSmsPermission({required Function(bool) onPermissionResult}) async {
    final result = await Permission.sms.request();
    if (result.isGranted) {
      onPermissionResult(true);
      return true;
    }
    onPermissionResult(false);
    return false;
  }

}