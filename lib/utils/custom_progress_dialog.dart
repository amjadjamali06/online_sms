import 'package:get/get.dart';
import 'package:flutter/material.dart';

/* Created By: Amjad Jamali on 22-Nov-2022 */

class ProgressDialog {

  static final ProgressDialog _instance = ProgressDialog._internal();
  ProgressDialog._internal();
  factory ProgressDialog() => _instance;

  bool isShowing = false;

  void showDialog({String? title}){
    if(isShowing)return;
    _autoCloseDialog();

    isShowing = true;
    Get.defaultDialog(
      title: "",
      titleStyle: const TextStyle(height: 0.0),
      content: Container(
        margin: const EdgeInsets.only(left: 12, right: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(
              width: 15,
            ),
            Text(
              title ?? 'Please wait...' ,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
      barrierDismissible: true,

      onWillPop: (){
        return Future.value(false);
      },
      radius: 10,
      cancel: GestureDetector(
          onTap: ()=>dismissDialog(),
          child: const Text('CANCEL', style: TextStyle(color: Colors.blue),)),
    );
  }

  void dismissDialog() {
    if (isShowing) {
      isShowing = false;
      Get.back();
    }
  }

  Future<void> _autoCloseDialog(){
    Future.delayed(const Duration(minutes: 1), () => dismissDialog(),);
    return Future.value();
  }

}
