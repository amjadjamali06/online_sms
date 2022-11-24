/* Created By: Amjad Jamali on 22-Nov-2022 */
import 'dart:developer';

import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'package:online_sms/models/response_model.dart';
import 'package:online_sms/services/http_client.dart';
import 'package:online_sms/utils/permission_utils.dart';


class CommonCode {

  static bool _isDetectingOTP = false;

  static Map<String, String> contacts = {};

  Future<bool> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }


  Future<bool> checkInternetAccess() async {
    HTTPClient httpClient = HTTPClient();
    if (await checkInternetConnection()) {
      print('--> true');
      ResponseModel response = await httpClient.getRequestWithOutHeader(
          url: "https://www.google.com/");
      return response.statusCode != 400 && response.statusCode != 408 &&
          response.statusCode != 500;
    }
    return false;
  }


  Future<String> autoPopulateOTP() async {
    if (!(await PermissionUtils().hasSmsPermission())) return '';
    if (_isDetectingOTP) return '';
    _isDetectingOTP = true;
    try {
      String comingSms = (await AltSmsAutofill().listenForSms ?? '')
          .toLowerCase();
      log('════════════════════SmsReceived> $comingSms');
      if (comingSms.isNotEmpty &&
          comingSms.startsWith("your otp(one-time-password) is:")) {
        RegExpMatch? match = RegExp(r'[0-9]{6}').firstMatch(comingSms);
        if (match != null) {
          String otp = match.input.substring(match.start, match.end);

          await Future.delayed(const Duration(milliseconds: 500));
          _isDetectingOTP = false;
          return otp;
        }
      }
      _isDetectingOTP = false;
    } catch (e) {
      return '';
    }
    return await autoPopulateOTP();
  }

  Future<bool> canRequestSMSPermission() async {
    return !(await PermissionUtils().hasSmsPermission());
  }

  void showToast(String message) {
    Fluttertoast.showToast(msg: message);
  }

  String getContactName(String number) {
    return contacts[number] ?? number;
  }

  static String getFormattedDate(String date) {
    DateTime? d = DateTime.tryParse(date);
    if (d != null) {
      date = DateFormat("dd-MM-yyyy").format(d);
      if (date == DateFormat("dd-MM-yyyy").format(DateTime.now())) {
        date = DateFormat("hh:mm a").format(d);
      } else if (date == DateFormat("dd-MM-yyyy").format(DateTime.now().subtract(const Duration(days: 1)))) {
        date = "Yesterday";
      } else if (d.isAfter(DateTime.now().subtract(const Duration(days: 6)))) {
        date = DateFormat("EEEE").format(d);
      }
    }
    return date;
  }

}
