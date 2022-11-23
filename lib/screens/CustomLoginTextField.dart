import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:online_sms/app_theme.dart';


/* @Author Faiza Farooqui
*create at 07-june-2021
* Last Modified by: Sadaf Khowaja on 20-Dec-2021
  */

class CustomLoginTextField extends StatelessWidget {
  final String? hint;
  final TextEditingController? textEditingController;
  final TextInputAction? inputAction;
  final TextInputType? keyboardType;
  final FocusNode? currentNode;
  final bool readOnly,isobscureText,isDense;
  final Widget? icon;
  TextCapitalization? textCapitalization;
  Function? onFieldSubmitted;
  void Function(String)? onChanged;
  List<TextInputFormatter>? inputFormatters;
  int? minLines;
  int? textLength;
  bool isErrorVisible;
  double marginLeft;
  double marginRight;
  double marginTop;
  double marginBottom;
  CustomLoginTextField({super.key,  this.hint,
    required this.textEditingController,
    this.keyboardType,
    this.currentNode,
    this.textCapitalization,
    this.onFieldSubmitted,
    this.onChanged,
    this.inputFormatters,
    this.readOnly =false,
    this.isobscureText =false,
    this.isDense =false,
    this.minLines,
    this.textLength,
    this.icon,
    this.inputAction,
    this.isErrorVisible =false,
    this.marginBottom =1,
    this.marginLeft =10,
    this.marginTop =10,
    this.marginRight =10,
  });

  @override
  Widget build(BuildContext context) {
    return textFieldNew();
  }

  Widget textFieldNew(){
    return Padding(
      padding: isErrorVisible?const EdgeInsets.fromLTRB(10, 5, 10, 0):EdgeInsets.fromLTRB(marginLeft, marginTop, marginRight, marginBottom),

      child: Material(
        color: Colors.transparent,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipPath(
          clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10))),
          child: Container(
            width: Get.width,
            decoration: BoxDecoration(
              color: MyTheme.kPrimaryColor,
              //borderRadius: BorderRadius.circular(10),
              border: Border(right: BorderSide(color: MyTheme.kPrimaryColor, width: 8,)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
              child: TextFormField(
                minLines: minLines??1,
                maxLength:textLength??255,
                controller:  textEditingController,
                obscureText: isobscureText,
                focusNode: currentNode,
                keyboardType: keyboardType,
                onChanged: onChanged,
                textInputAction: inputAction,
                decoration: InputDecoration(
                  counterText: '',
                  isDense: true, // important line
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: hint,
                  suffixIcon: Visibility(
                    visible: icon != null,
                    child: Container(
                        padding: const EdgeInsets.all(12.0),
                        child: icon
                    ),
                  ),
                  hintStyle: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFFA1A4B2) ,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  filled: true,
                  fillColor: MyTheme.kPrimaryColorVariant,
                  contentPadding: const EdgeInsets.fromLTRB(8, 10, 10, 10),
                ),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black ,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

