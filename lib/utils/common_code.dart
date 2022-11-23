/* Created By: Amjad Jamali on 22-Nov-2022 */
import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import 'package:online_sms/models/response_model.dart';
import 'package:online_sms/services/http_client.dart';
import 'package:online_sms/utils/permission_utils.dart';


class CommonCode {

  static bool _isDetectingOTP = false;

  static TextEditingController _teController = TextEditingController();

  Future<bool> checkInternetConnection()async{
    var connectivityResult = await Connectivity().checkConnectivity();
    if((connectivityResult==ConnectivityResult.mobile ||
        connectivityResult==ConnectivityResult.wifi)){
      return true;
    }
    return false;
  }


  Future<bool> checkInternetAccess() async {
    HTTPClient httpClient = HTTPClient();
    ResponseModel response = await httpClient.getRequest(
        url: "https://www.google.com/");
    if (response.statusCode != 400 && response.statusCode != 408 &&
        response.statusCode != 500) {
      return await checkInternetConnection() && true;
    }
    return await checkInternetConnection() && false;
  }



  Future<String> autoPopulateOTP(TextEditingController controller) async {
    if(!(await  PermissionUtils().hasSmsPermission()))return '';
    _teController = controller;
    if(_isDetectingOTP)return '';
    _isDetectingOTP = true;
    try {
      String comingSms = (await AltSmsAutofill().listenForSms??'').toLowerCase();
      _isDetectingOTP = false;
      if(comingSms.isNotEmpty && comingSms.startsWith("Your OTP(One-Time-Password) is :")){

        RegExpMatch? match = RegExp(r'[0-9]{6}').firstMatch(comingSms);
        if(match!=null){
          String otp = match.input.substring(match.start, match.end);

          await Future.delayed(const Duration(milliseconds: 500));
          return otp;
        }
      }
    } catch(e) {
      return '';
    }
    return await autoPopulateOTP(_teController);
  }

  Future<bool> canRequestSMSPermission() async {
    return !(await PermissionUtils().hasSmsPermission());
  }


}
