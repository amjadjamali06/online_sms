import 'package:shared_preferences/shared_preferences.dart';

/* Created By: Amjad Jamali on 22-Nov-2022 */

class UserSession {

  UserSession._internal();
  static final UserSession _instance = UserSession._internal();
  factory UserSession(){
    return _instance;
  }

  static const String MOBILE_NUMBER = "MOBILE_NUMBER";


  Future<bool> saveMobileNumber({required String mobile}) async {
    final preference = await SharedPreferences.getInstance();
    preference.setString(MOBILE_NUMBER, mobile);
    return true;
  }

  Future<String> getMobileNumber() async {
    final preference = await SharedPreferences.getInstance();
    return preference.getString(MOBILE_NUMBER)??"";
  }


}
