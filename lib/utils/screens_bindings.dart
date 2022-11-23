/* Created By: Amjad Jamali on 22-Nov-2022 */

import 'package:get/get.dart';
import 'package:online_sms/controllers/login_screen_controller.dart';

class ScreensBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginScreenController());

  }
}

