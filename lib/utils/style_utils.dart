import 'package:flutter/material.dart';
import 'package:weather_app/app_constants/constants.dart';

class StyleUtil {
  static primaryTextFieldDecoration({String? hintText, Widget? prefix}) {
    return InputDecoration(
      prefixIcon: prefix,
      counterText: '',
      contentPadding:
          const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
      hintText: hintText,
      hintStyle: TextStyle(color: Constants.grey),
      fillColor: Constants.white,
      filled: true,
      focusedBorder: primaryOutlineInputBorderLight(),
      enabledBorder: primaryOutlineInputBorderLight(),
      border: primaryOutlineInputBorderLight(),
      errorBorder: primaryOutlineInputBorderLight(),
      disabledBorder: primaryOutlineInputBorderLight(),
    );
  }

  // static primaryDropDownDecoration({String? hintText, Widget? prefix}) {
  //   return InputDecoration(
  //     filled: true,
  //     fillColor: Constants.white,
  //     contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.w),
  //     focusedBorder: StyleUtil.defaultTextFieldBorder(),
  //     enabledBorder: StyleUtil.defaultTextFieldBorder(),
  //     border: StyleUtil.defaultTextFieldBorder(),
  //     errorBorder: StyleUtil.defaultTextFieldBorder(),
  //     disabledBorder: StyleUtil.defaultTextFieldBorder(),
  //   );
  // }

  // static defaultTextFieldBorder() {
  //   return DecoratedInputBorder(
  //     child: OutlineInputBorder(
  //         borderRadius: const BorderRadius.all(Radius.circular(8.0)),
  //         borderSide: BorderSide(color: Constants.borderColor3, width: 1)),
  //     shadow: StyleUtil.textFieldShadow(),
  //   );
  // }

  static primaryOutlineInputBorderLight() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: Colors.transparent),
    );
  }

  static formTextFieldInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: Constants.grey),
    );
  }
}
