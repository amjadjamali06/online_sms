import 'package:get/get.dart';
import 'package:online_sms/screens/login_screen.dart';
import 'package:online_sms/utils/constant.dart';
import 'package:online_sms/utils/screens_bindings.dart';
/* Created By: Amjad Jamali on 22-Nov-2022 */

class RouteGenerator {
  static List<GetPage> getPages() {
    return [
      // GetPage(
      //     name: kSplashScreenRoute,
      //     page: () => LoginScreen(),
      //     binding: ScreensBindings()),
      GetPage(
          name: kLoginScreenRoute,
          page: () => LoginScreen(),
          binding: ScreensBindings()),

    ];
  }
}
