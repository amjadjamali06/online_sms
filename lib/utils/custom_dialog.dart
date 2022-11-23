/*
* @Author Sadaf Khowaja 26-Oct-2021
* Last Modified: Amjad Jamali on 15-Dec-2021
* * Last Modified by: Sadaf Khowaja on 20-Dec-2021
* Last Modified by Uzair on 06-Sept-2022
* */


import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_sms/app_theme.dart';

class CustomDialogs{

  static final CustomDialogs _instance = CustomDialogs._internal();
  CustomDialogs._internal();
  factory CustomDialogs() => _instance;



  void showSmsPermissionDialog({required Function onYes, required Function onNo, required Function onDoNotAsk}) {
    RxBool doNotAskValue = false.obs;
    AwesomeDialog(
      dismissOnBackKeyPress: true,
      context: Get.context!,
      headerAnimationLoop: false,
      animType: AnimType.SCALE,
      dismissOnTouchOutside: false,
      //desc: message,
      body: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              Text('Permission Required',
                  style: TextStyle(
                      color: MyTheme.kPrimaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),

              const Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10, top: 20),
                child: Text(
                  // 'Allow SMS Permission for Auto read OTP from SMS',
                  'SBP Mobile is requesting SMS Permission to read incoming SMS, '
                      'this is required for auto detect OTP from SMS',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, bottom: 12),
                child: Row(
                  children: [
                    Obx(() =>
                        Theme(
                          data: ThemeData(
                              unselectedWidgetColor: MyTheme.kPrimaryColor),
                          child: Checkbox(
                              materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                              activeColor: MyTheme.kPrimaryColor,
                              value: doNotAskValue.value,
                              onChanged: (value) {
                                doNotAskValue.value = value!;
                              }),
                        )),
                    const Text(
                      "Don't ask again",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              )
            ],
          )),
      customHeader: Container(
        margin: const EdgeInsets.all(6),
        child: Image.asset("assets/images/app_logo.png"),
      ),
      btnOkColor: Colors.green,
      btnOkText: 'Allow',
      btnOkOnPress: ()=> onYes(),
      btnCancelText: 'Skip',
      btnCancelOnPress: ()=> doNotAskValue.isTrue ? onDoNotAsk() : onNo(),
      btnCancelColor: Colors.red,
      autoDismiss: true,
    ).show();
  }

  void showDialog(String title, String description, DialogType type, Color btnOkColor, {Function? onOkBtnPressed}) {
    AwesomeDialog(
      dismissOnBackKeyPress: false,
      context: Get.context!,
      dialogType: type,
      headerAnimationLoop: false,
      animType: AnimType.SCALE,
      btnOkColor: btnOkColor,
      title: title,
      dismissOnTouchOutside: false,
      desc: description,
      customHeader: Container(
        margin: const EdgeInsets.all(6),
        child: Image.asset("assets/images/app_logo.png"),),
      btnOkOnPress: () {
        if(onOkBtnPressed != null ){
          onOkBtnPressed();
        }
      },
    ).show();
  }


}
