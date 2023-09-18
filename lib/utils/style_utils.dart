// import 'package:flutter/material.dart';
// import 'package:skilltest/app_constants/constants.dart';

// class StyleUtil {
//   static BoxDecoration defaultBoxDecoration() {
//     return BoxDecoration(
//       color: Constants.textWhite,
//       borderRadius: BorderRadius.circular(8),
//       border: Border.all(color: Constants.borderColor3, width: 1),
//       boxShadow: StyleUtil.primaryShadow(),
//     );
//   }

//   static LinearGradient getMapScreenBottomGradientLight() {
//     return LinearGradient(
//       begin: Alignment.bottomCenter,
//       end: Alignment.topCenter,
//       colors: [
//         Colors.white,
//         Colors.white.withOpacity(0),
//       ],
//     );
//   }

//   static List<BoxShadow> primaryShadow() {
//     return [
//       BoxShadow(
//         color: Constants.shadowColor2,
//         blurRadius: 4,
//         // offset: const Offset(0, 0),
//       )
//       // BoxShadow(
//       //   color: Constants.black.withOpacity(0.25),
//       // ),
//       // BoxShadow(
//       //   color: Constants.white,
//       //   blurRadius: 4,
//       //   offset: const Offset(0, 4),
//       // ),
//     ];
//   }

//   static List<BoxShadow> cardShadow() {
//     return [
//       BoxShadow(
//         color: Constants.shadowColor,
//         blurRadius: 12,
//         offset: const Offset(0, 0),
//       ),
//     ];
//   }

//   static BoxShadow textFieldShadow() {
//     return BoxShadow(
//       color: Constants.shadowColor2,
//       blurRadius: 4,
//       // offset: const Offset(0, 0),
//     );
//   }

//   static List<BoxShadow> jobCardShadow() {
//     return [
//       BoxShadow(color: HexColor('C7C7DE').withOpacity(0.5), blurRadius: 8)
//     ];
//   }

//   static primaryTextFieldDecoration({String? hintText, Widget? prefix}) {
//     return InputDecoration(
//       prefixIcon: prefix,
//       counterText: '',
//       contentPadding:
//           const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
//       hintText: hintText,
//       hintStyle: TextStyle(color: Constants.grey),
//       fillColor: Constants.white,
//       filled: true,
//       focusedBorder: primaryOutlineInputBorderLight(),
//       enabledBorder: primaryOutlineInputBorderLight(),
//       border: primaryOutlineInputBorderLight(),
//       errorBorder: primaryOutlineInputBorderLight(),
//       disabledBorder: primaryOutlineInputBorderLight(),
//     );
//   }

//   static primaryDropDownDecoration({String? hintText, Widget? prefix}) {
//     return InputDecoration(
//       filled: true,
//       fillColor: Constants.white,
//       contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.w),
//       focusedBorder: StyleUtil.defaultTextFieldBorder(),
//       enabledBorder: StyleUtil.defaultTextFieldBorder(),
//       border: StyleUtil.defaultTextFieldBorder(),
//       errorBorder: StyleUtil.defaultTextFieldBorder(),
//       disabledBorder: StyleUtil.defaultTextFieldBorder(),
//     );
//   }

//   static defaultTextFieldBorder() {
//     return DecoratedInputBorder(
//       child: OutlineInputBorder(
//           borderRadius: const BorderRadius.all(Radius.circular(8.0)),
//           borderSide: BorderSide(color: Constants.borderColor3, width: 1)),
//       shadow: StyleUtil.textFieldShadow(),
//     );
//   }

//   static primaryOutlineInputBorderLight() {
//     return OutlineInputBorder(
//       borderRadius: BorderRadius.circular(12.0),
//       borderSide: const BorderSide(color: Colors.transparent),
//     );
//   }

//   static formTextFieldInputBorder() {
//     return OutlineInputBorder(
//       borderRadius: BorderRadius.circular(8.0),
//       borderSide: BorderSide(color: Constants.grey),
//     );
//   }
// }
