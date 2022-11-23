import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_sms/app_theme.dart';
import 'package:online_sms/controllers/login_screen_controller.dart';
import 'package:online_sms/screens/CustomLoginTextField.dart';


/* Created by Luqman on 03-August-2021
*  Last Modified by Luqman on 05-August-2021
* Last Modified by: Sadaf Khowaja on 20-Dec-2021
* Last Modified by Luqman on 27-Nov-2021
* Last Modified: Amjad Jamali on 24-Dec-2021
* Last Modified by Uzair on 13-Aug-2022
  */

class LoginScreen extends GetView<LoginScreenController> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: _getBody(context),
      key: controller.scaffoldKey,

    );
  }

  Widget _getBody(context) {
    return Stack(
      children: [

        SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Padding(
                padding: EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 25.0),
                child: Center(
                    child: Image(
                  image: AssetImage("assets/images/user_icon.png"),
                  width: 300,
                )),
              ),
              Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Hello!\nPlease enter your Mobile Number below to get started!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  )),
              Container(
                margin: const EdgeInsets.fromLTRB(18, 16, 18, 20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 20),
                  child: Obx(() => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.fromLTRB(12, 8.0, 12, 0),
                        alignment: Alignment.centerLeft,
                        child: _getErrorMessage(errorMessage: controller.mobileNoErrorMessage),
                      ),
                      _mobileNoField(),

                      const SizedBox(height: 32),

                      Transform.translate(
                        offset: const Offset(0.0, 0.0),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () async {
                              controller.onSubmitPressed();
                            },
                            child: Container(
                                margin: const EdgeInsets.only(
                                    right: 20),
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    color: MyTheme.kPrimaryColor,
                                    borderRadius:
                                        BorderRadius.circular(
                                            60),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 1.5,
                                        spreadRadius: 1.5,
                                      ),
                                    ]),
                                // margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.12),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(
                                          60.0),
                                  child: const Icon(
                                    Icons.arrow_forward,
                                    size: 50.0,
                                    color: Colors.white,
                                  ),
                                )),
                          ),
                        ),
                      ),
                    ],
                  )),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }



  Widget otpSubmitButton() {
    return Transform.translate(
      offset: const Offset(0.0, 0.0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: GestureDetector(
          onTap: controller.isTimerContinue.value == true
              ? () async {
                  controller.onSubmitPressed();
                }
              : null,
          child: Container(
              margin: const EdgeInsets.only(right: 20, bottom: 8),
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  color: MyTheme.kPrimaryColor,
                  borderRadius: BorderRadius.circular(60),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 1.5,
                      spreadRadius: 1.5,
                    ),
                  ]),
              // margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60.0),
                child: const Icon(
                  Icons.arrow_forward,
                  size: 50.0,
                  color: Colors.white,
                ),
              )),
        ),
      ),
    );
  }

  Widget _mobileNoField() {
    return CustomLoginTextField(
      isErrorVisible: controller.mobileNoErrorMessage.isNotEmpty,
      textEditingController: controller.mobileNoTEController,
      currentNode: controller.mobileNoFocusNode,
      inputAction: TextInputAction.next,
      hint: "Mobile Number",
      icon: const Icon(Icons.sim_card, color: Colors.white54,),
      onChanged: (value) {
        controller.checkMobileNoValidity();
      },
    );
  }






  Widget _getErrorMessage(
      {required RxString errorMessage}) {
    return Obx(
      () => Visibility(
        visible: errorMessage.isNotEmpty,
        child: Padding(
          padding: const EdgeInsets.only(left: 0.0, bottom: 3.0),
          child: Text(
            errorMessage.value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.redAccent,
            ),
          ),
        ),
      ),
    );
  }
}
