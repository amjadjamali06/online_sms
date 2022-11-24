/* created by amjad for dummy data because services are not working every time. */

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_sms/app_theme.dart';
import 'package:online_sms/services/rest_api_url.dart';
import 'package:online_sms/utils/common_code.dart';
import 'package:online_sms/utils/user_session.dart';


class DummyData {

  static String baseUrl =   "http://192.168.110.73:8080/";
  static bool debugMode = false;

  static int otp = 0;

  static int generateOTP() {
    otp = Random().nextInt(900000)+100000;
    return  otp;
  }



  //////////// UI ///////////////

  Future<void> showUpdateURLDialog() async {
    const double padding = 10.0;
    const double avatarRadius = 66.0;
    String url = await UserSession().getBaseUrl();
    TextEditingController urlTEController = TextEditingController(text: url);
    FocusNode focusNode = FocusNode();

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Container(
          width: Get.width,
          padding: const EdgeInsets.only(
            top: padding,
            bottom: padding,
            left: padding,
            right: padding,
          ),
          margin: const EdgeInsets.only(top: avatarRadius),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(padding),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
            CrossAxisAlignment.start, // To make the card compact
            children: <Widget>[

              const SizedBox(height: 12,),

              TextField(
                controller: urlTEController,
                onChanged: (s){},
                focusNode: focusNode,
                keyboardType: TextInputType.text,
                onSubmitted: (s){
                  focusNode.unfocus();
                },

                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: MyTheme.kPrimaryColorVariant)),
                    hintText: 'Enter Base URL',
                    labelText: 'Base URL',
                    suffixStyle: TextStyle(color: MyTheme.kPrimaryColorVariant)),

              ),


              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 12),
                child: ElevatedButton(
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(MyTheme.kPrimaryColorVariant),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.7),
                              side: BorderSide(color: MyTheme.kPrimaryColorVariant))) // foreground
                  ),
                  onPressed: (){

                    if(urlTEController.text.startsWith('http') && urlTEController.text.endsWith('/') && !urlTEController.text.contains(' ')){
                      focusNode.unfocus();
                      UserSession().setBaseUrl(urlTEController.text);
                      baseUrl = urlTEController.text;
                      updateUrls();
                      Get.back();
                    }else {
                      focusNode.requestFocus();
                      CommonCode().showToast("Please Provide a Valid URL");
                      return;
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      "UPDATE",
                      style: TextStyle(fontWeight: FontWeight.values[4], fontSize: 13),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }




  void updateUrls(){
    kGenerateOTPURL = "${baseUrl}generateOTP";
    kSendMessageURL = "${baseUrl}sms";
  }

}
