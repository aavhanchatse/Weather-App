// import 'dart:async';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:pinktree_user/app_constants/constants.dart';
// import 'package:pinktree_user/models/doctor_data.dart';
// import 'package:pinktree_user/models/user_data.dart';
// import 'package:pinktree_user/repo/auth_repo.dart';
// import 'package:pinktree_user/utils/device_info_util.dart';
// import 'package:pinktree_user/utils/size_config.dart';
// import 'package:pinktree_user/utils/snackbar_util.dart';
// import 'package:pinktree_user/utils/storage_manager.dart';
// import 'package:pinktree_user/view/auth_screens/doctor_registration_screen.dart';
// import 'package:pinktree_user/view/auth_screens/registration_screen.dart';
// import 'package:pinktree_user/view/screens/doctor_nav_bar.dart';
// import 'package:pinktree_user/view/screens/nav_bar.dart';
// import 'package:pinktree_user/view/widgets/primary_button.dart';
// import '../../controllers/auth_controller.dart';
// import '../widgets/custom_scaffold_body.dart';

// class OTPScreen extends StatefulWidget {
//   final UserData? userData;
//   final DoctorData? doctorData;
//   final bool? isDoctor;

//   const OTPScreen(
//       {Key? key, this.userData, this.doctorData, this.isDoctor = false})
//       : super(key: key);

//   @override
//   State<OTPScreen> createState() => _OTPScreenState();
// }

// class _OTPScreenState extends State<OTPScreen> {
//   bool isShowTimer = true;
//   Timer? _timer;
//   int _start = 60;

//   String? _otp = '';
//   bool hasError = false;

//   var firebaseAuth = FirebaseAuth.instance;
//   String? actualCode;
//   ConfirmationResult? _confirmationResult;
//   AuthCredential? _authCredential;

//   final _formKey = GlobalKey<FormState>();

//   final AuthController authController = Get.find<AuthController>();

//   @override
//   void dispose() {
//     _timer!.cancel();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     startTimer();
//     verifyPhone();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CustomScaffoldBody(
//       body: Scaffold(
//         body: SingleChildScrollView(
//           child: Stack(
//             children: [
//               Container(
//                 // AppBar().preferredSize.height -
//                 // MediaQuery.of(context).viewPadding.top,
//                 width: 100.w,
//                 padding: EdgeInsets.symmetric(horizontal: 6.w),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       SizedBox(height: 8.h),
//                       _logoWidget(),
//                       SizedBox(height: 3.h),
//                       _headingImage(),
//                       SizedBox(height: 3.h),
//                       _headingWidget(),
//                       SizedBox(height: 4.h),
//                       _pinCodeTextField(),
//                       _resendCodeText(),
//                       SizedBox(height: 4.h),
//                       _button(),
//                       SizedBox(height: 6.w),
//                     ],
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 5.h,
//                 child: IconButton(
//                   onPressed: () {
//                     Get.back();
//                   },
//                   icon: Icon(
//                     Icons.arrow_back,
//                     color: Constants.primaryGreyLight,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _logoWidget() {
//     return Center(
//       child: Column(
//         children: [
//           Image.asset(
//             'assets/images/common/logo.png',
//             width: 37.w,
//           ),
//           SizedBox(
//             height: 1.2.h,
//           ),
//           Text(
//             'Be Lung Healthy'.tr,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//                 color: Constants.black, fontSize: 1.5.t, fontFamily: 'Poppins'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _headingImage() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Image.asset(
//           'assets/images/login_Screen/otp.png',
//           width: 70.w,
//         ),
//       ],
//     );
//   }

//   Widget _headingWidget() {
//     final AuthController authController = Get.find<AuthController>();

//     return Center(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(
//             'Verification Code'.tr,
//             style: const TextStyle(
//               fontSize: 17,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           SizedBox(height: 0.7.h),
//           Obx(
//             () => RichText(
//               textAlign: TextAlign.center,
//               text: TextSpan(
//                 text: 'We’ve sent the verification code \nto ',
//                 style: TextStyle(
//                   fontSize: 1.6.t,
//                   color: Constants.textGrey,
//                   fontWeight: FontWeight.normal,
//                   fontFamily: 'Poppins',
//                 ),
//                 children: <TextSpan>[
//                   TextSpan(
//                     text:
//                         "${authController.countryCode.value} ${authController.phoneNumber.value}.",
//                     style: TextStyle(
//                       fontWeight: FontWeight.w500,
//                       color: Constants.black,
//                       fontFamily: 'Poppins',
//                     ),
//                   ),
//                   TextSpan(
//                     text: ' Change phone number?',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       color: Constants.secondaryColor,
//                       fontFamily: 'Poppins',
//                     ),
//                     recognizer: TapGestureRecognizer()
//                       ..onTap = () {
//                         Get.back();
//                       },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _pinCodeTextField() {
//     return PinCodeTextField(
//       appContext: context,
//       length: 6,
//       animationType: AnimationType.fade,
//       autovalidateMode: AutovalidateMode.disabled,
//       validator: (value) {
//         if (value!.length != 6) {
//           return 'Enter Valid Pin';
//         }
//         return null;
//       },
//       textStyle: const TextStyle(
//         fontSize: 20,
//         fontWeight: FontWeight.normal,
//       ),
//       autoFocus: true,
//       pinTheme: PinTheme(
//         shape: PinCodeFieldShape.box,
//         borderRadius: BorderRadius.circular(16),
//         fieldHeight: 50,
//         fieldWidth: 50,
//         activeFillColor: Constants.secondaryColor,
//         inactiveFillColor: Constants.primaryInputBgColor,
//         inactiveColor: Constants.primaryInputBgColor,
//         activeColor: Constants.primaryInputBgColor,
//         selectedFillColor: Constants.secondaryColor,
//         selectedColor: Constants.primaryInputBgColor,
//       ),
//       errorTextSpace: 24,
//       cursorColor: Constants.black,
//       animationDuration: const Duration(milliseconds: 300),
//       enableActiveFill: true,
//       keyboardType: TextInputType.number,
//       // boxShadows: StyleUtil.primaryShadowLight(),
//       onCompleted: (v) {
//         debugPrint("Completed");
//       },
//       onChanged: (value) {
//         _otp = value;
//         setState(() {});
//       },
//     );
//   }

//   Widget _resendCodeText() {
//     return SizedBox(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (isShowTimer)
//             RichText(
//               text: TextSpan(
//                 text: 'Resend code after ',
//                 style: TextStyle(
//                   color: Constants.textGrey,
//                   fontWeight: FontWeight.normal,
//                   fontFamily: 'Poppins',
//                 ),
//                 children: <TextSpan>[
//                   TextSpan(
//                     text: "00:$_start",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Constants.secondaryColor,
//                       fontFamily: 'Poppins',
//                     ),
//                     recognizer: TapGestureRecognizer()
//                       ..onTap = () {
//                         // Get.back();
//                       },
//                   ),
//                 ],
//               ),
//             ),
//           if (!isShowTimer)
//             TextButton(
//               onPressed: () {
//                 _start = 60;
//                 startTimer();
//                 verifyPhone();
//               },
//               child: Text(
//                 'Resend',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Constants.secondaryColor,
//                   fontFamily: 'Poppins',
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _button() {
//     return SizedBox(
//       width: double.infinity,
//       child: PrimaryButton(onPressed: _next, title: 'Verify'),
//     );
//   }

//   void _next() {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }

//     if (_otp!.length == 6) {
//       _signInWithPhoneNumber(_otp!);
//     } else {
//       SnackBarUtil.showSnackBar('enter_correct_otp'.tr);
//     }
//   }

//   void _signInWithPhoneNumber(String smsCode) async {
//     _authCredential = PhoneAuthProvider.credential(
//         verificationId: actualCode!, smsCode: smsCode);

//     debugPrint('authCredentials: $_authCredential');

//     firebaseAuth.signInWithCredential(_authCredential!).catchError((error) {
//       debugPrint('error in signing with creds: $error');

//       SnackBarUtil.showSnackBar('Please enter correct OTP');
//     }).then((result) {
//       debugPrint('result : $result');

//       if (result != null && result.user != null) _goToPasswordSetupPage();
//     });
//   }

//   void _goToPasswordSetupPage() {
//     if (widget.isDoctor == false) {
//       if (widget.userData != null) {
//         _storeData(widget.userData!);
//         Get.find<AuthController>().resetAll();
//         Get.offAll(() => const NavBar());
//       } else {
//         Get.off(() => RegistrationScreen());
//       }
//     } else if (widget.isDoctor == true) {
//       if (widget.doctorData != null) {
//         _storeDoctorData(widget.doctorData!);
//         Get.find<AuthController>().resetAll();
//         Get.offAll(() => const DoctorNavBar());
//       } else {
//         // doctor registration
//         Get.off(() => const DoctorRegistrationScreen());
//       }
//     }
//   }

//   void startTimer() {
//     const oneSec = Duration(seconds: 1);

//     _timer = Timer.periodic(
//       oneSec,
//       (Timer timer) {
//         if (_start == 0) {
//           setState(() {
//             isShowTimer = false;
//             timer.cancel();
//           });
//         } else {
//           setState(() {
//             isShowTimer = true;
//             _start--;
//           });
//         }
//       },
//     );
//   }

//   Future<void> verifyPhone() async {
//     final PhoneCodeSent codeSent =
//         (String verificationId, [int? forceResendingToken]) async {
//       actualCode = verificationId;
//       debugPrint(
//           'Code sent to ${authController.countryCode.value}${authController.phoneNumber.value.trim()}');

//       SnackBarUtil.showSnackBar(
//           "Enter the code sent to ${authController.countryCode.value}${authController.phoneNumber.value.trim()}");
//     };

//     final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
//         (String verificationId) {
//       // actualCode = verificationId;

//       debugPrint("Firebase otp auto retrive time out");
//     };

//     final PhoneVerificationFailed verificationFailed = (authException) {
//       debugPrint("authException.message: ${authException.message}");

//       if (authException.message!.contains('not authorized')) {
//         SnackBarUtil.showSnackBar('Something has gone wrong, please try later');
//       } else if (authException.message!.contains('Network')) {
//         SnackBarUtil.showSnackBar(
//             'Please check your internet connection and try again');
//       } else {
//         SnackBarUtil.showSnackBar('Something has gone wrong, please try later');
//       }
//     };

//     final PhoneVerificationCompleted verificationCompleted =
//         (AuthCredential auth) {
//       debugPrint('Auto retrieving verification code');
//       // _authCredential = auth;
//       // firebaseAuth.signInWithCredential(_authCredential!).then((value) {
//       //   if (value.user != null) {
//       //     _goToPasswordSetupPage();
//       //   } else {
//       //     SnackBarUtil.showSnackBar('Invalid OTP');
//       //   }
//       // }).catchError((error) {
//       //   SnackBarUtil.showSnackBar('Something has gone wrong, please try later');
//       // });
//     };

//     debugPrint(
//         "OTP send start ${authController.countryCode.value}${authController.phoneNumber.value.trim()}");

//     return firebaseAuth.verifyPhoneNumber(
//         phoneNumber:
//             "${authController.countryCode.value}${authController.phoneNumber.value.trim()}",
//         timeout: const Duration(seconds: 60),
//         verificationCompleted: verificationCompleted,
//         verificationFailed: verificationFailed,
//         codeSent: codeSent,
//         codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
//   }

//   void _storeData(UserData userData) async {
//     // StorageManager().setToken(token);
//     StorageManager().setUserData(userData);

//     final deviceId = await DeviceInfoUtil.getDeviceId();
//     final fcmToken = await FirebaseMessaging.instance.getToken();

//     debugPrint('deviceId: $deviceId');
//     debugPrint('fcmToken: $fcmToken');

//     Map map = {
//       "userId": userData.id,
//       "deviceId": deviceId,
//       "fcmToken": fcmToken,
//       "userType": "patient"
//     };

//     AuthRepo().saveDeviceInfo(map);
//   }

//   void _storeDoctorData(DoctorData doctorData) async {
//     // StorageManager().setToken(token);
//     StorageManager().setDoctorData(doctorData);

//     final deviceId = await DeviceInfoUtil.getDeviceId();
//     final fcmToken = await FirebaseMessaging.instance.getToken();

//     debugPrint('deviceId: $deviceId');
//     debugPrint('fcmToken: $fcmToken');

//     Map map = {
//       "userId": doctorData.id,
//       "deviceId": deviceId,
//       "fcmToken": fcmToken,
//       "userType": "doctor"
//     };

//     AuthRepo().saveDeviceInfo(map);
//   }
// }
