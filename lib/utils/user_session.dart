import 'package:shared_preferences/shared_preferences.dart';

/* Created By: Amjad Jamali on 22-Nov-2022 */

class UserSession {

  UserSession._internal();
  static final UserSession _instance = UserSession._internal();
  factory UserSession(){
    return _instance;
  }

  static String MOBILE_NUMBER = "";

  final String _baseUrl = "baseUrl";
  final String _mobileNumber = "mobileNumber";

  Future<bool> saveMobileNumber({required String mobile}) async {
    final preference = await SharedPreferences.getInstance();
    preference.setString(_mobileNumber, mobile);
    return true;
  }

  Future<String> getMobileNumber() async {
    final preference = await SharedPreferences.getInstance();
    MOBILE_NUMBER = preference.getString(_mobileNumber)??"";
    return MOBILE_NUMBER;
  }

  //TODO Remove After Service Deployment
  Future<String> getBaseUrl()async{
    return Future.value((await SharedPreferences.getInstance())
        .getString(_baseUrl) ?? "http://192.168.110.73:8080/");
  }
  Future<bool> setBaseUrl(String baseUrl)async{
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences.setString(_baseUrl, baseUrl);
    return true;
  }

}
