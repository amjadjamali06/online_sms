/*
* Last Modified by: Sadaf Khowaja on 01-Jan-2022
* Last Modified: Amjad Jamali on 28-Apr-2022
* Last Modified by Uzair on 13-Aug-2022
*/

import 'dart:async';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_sms/models/response_model.dart';
import 'package:online_sms/screens/home_page.dart';
import 'package:online_sms/services/user_service.dart';
import 'package:online_sms/utils/common_code.dart';
import 'package:online_sms/utils/custom_dialog.dart';
import 'package:online_sms/utils/custom_progress_dialog.dart';
import 'package:online_sms/utils/permission_utils.dart';
import 'package:online_sms/utils/user_session.dart';



class LoginScreenController extends GetxController {

  String sentOTP = '';



  FocusNode mobileNoFocusNode = FocusNode();
  TextEditingController mobileNoTEController = TextEditingController();
  RxString mobileNoErrorMessage = "".obs;


  RxString otpErrorMsg = ''.obs; RxString otpFieldLengthErrorMsg = ''.obs;
  RxBool obscure = true.obs; RxBool otpFieldLengthErrorVisible = false.obs;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final ProgressDialog _progressDialog = ProgressDialog();

  RxInt secondsToDisplay = 0.obs, newSecond=0.obs,start = 295.obs;
  String remainingTimeToResendOTP = "0:00";
  RxBool isTimerContinue = false.obs;
  Timer? timer;
  RxInt expiryTime = 295.obs;
  String redirectPage = "";



  //Get values from shared preferences
  void getStoredMobileNumber()async{
    String mobile = await UserSession().getMobileNumber();
    if(mobile.isNotEmpty)
      Get.off(HomePage());
  }

  @override
  void onInit() {
    redirectPage = Get.arguments??"";
    super.onInit();
    getStoredMobileNumber();
  }


  bool checkMobileNoValidity() {
    if (mobileNoTEController.text.trim().isNotEmpty) {
      mobileNoErrorMessage.value = "";
      return true;
    } else {
      mobileNoErrorMessage.value = "Phone Number is required!";
    }
    return false;
  }





  Future<void> onSubmitPressed() async {
    if (checkMobileNoValidity()) {
      if (!(await PermissionUtils().hasSmsPermission())) {
        PermissionUtils().requestSmsPermission(onPermissionResult: (isGranted) {
          onSubmitPressed();
        });
        return;
      }

      _progressDialog.showDialog(title: 'Verifying Number...');

      // bool checkInternetAvailability = await CommonCode().checkInternetAccess();
      if (true) {
        //Call Login Service
        ResponseModel response = await UserService().sendOTP(phoneNumber: mobileNoTEController.value.text.trim());


        if (response.data != null && response.statusCode == 200 && response.data is int) {
          sentOTP = "${response.data}";
          // _progressDialog.showDialog(title: "Fetching OTP");
          CommonCode().autoPopulateOTP(mobileNoTEController).then((receivedOTP) {
            if (receivedOTP.isNotEmpty) {
              onVerifyOtpBtnPress(receivedOTP);
            }
          });
        } else {
          _progressDialog.dismissDialog();
          CustomDialogs().showDialog(
            "Alert",
            "${response.data}",
            DialogType.ERROR,
            Colors.red,
          );
        }
      }
    }else{
      _progressDialog.dismissDialog();

      Get.to(HomePage());
    }
  }

  Future<void> onVerifyOtpBtnPress(String receivedOTP) async {
    if(receivedOTP == sentOTP){
      await UserSession().saveMobileNumber(mobile: mobileNoTEController.text.trim());
      Get.to(HomePage());
    }
    _progressDialog.dismissDialog();
  }




}
