import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:weather_app/app_constants/assets_paths.dart';
import 'package:weather_app/app_constants/constants.dart';
import 'package:weather_app/utils/default_snackbar_util.dart';
import 'package:weather_app/utils/gesturedetector_util.dart';
import 'package:weather_app/utils/size_config.dart';
import 'package:weather_app/view/screens/home_screen.dart';
import 'package:weather_app/view/widgets/primary_button.dart';

import '../../controllers/auth_controller.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  bool isShowTimer = true;
  Timer? _timer;
  int _start = 60;

  String? _otp = '';
  bool hasError = false;

  var firebaseAuth = FirebaseAuth.instance;
  String? actualCode;
  ConfirmationResult? _confirmationResult;
  AuthCredential? _authCredential;

  final _formKey = GlobalKey<FormState>();

  final AuthController authController = Get.find<AuthController>();

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
    verifyPhone();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GestureDetectorUtil.onScreenTap();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                // AppBar().preferredSize.height -
                // MediaQuery.of(context).viewPadding.top,
                width: 100.w,
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(height: 8.h),
                      _headingImage(),
                      SizedBox(height: 3.h),
                      _headingWidget(),
                      SizedBox(height: 4.h),
                      _pinCodeTextField(),
                      _resendCodeText(),
                      SizedBox(height: 4.h),
                      _button(),
                      SizedBox(height: 6.w),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 5.h,
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Constants.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _logoWidget() {
    return Center(
      child: Column(
        children: [
          Image.asset(
            'assets/images/common/logo.png',
            width: 37.w,
          ),
          SizedBox(
            height: 1.2.h,
          ),
          Text(
            'Be Lung Healthy'.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Constants.black, fontSize: 1.5.t, fontFamily: 'Poppins'),
          ),
        ],
      ),
    );
  }

  Widget _headingImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AssetsPath.loginLogo,
          width: 70.w,
        ),
      ],
    );
  }

  Widget _headingWidget() {
    final AuthController authController = Get.find<AuthController>();

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Verification Code'.tr,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 0.7.h),
          Obx(
            () => RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'We’ve sent the verification code \nto ',
                style: TextStyle(
                  fontSize: 1.6.t,
                  color: Constants.black,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins',
                ),
                children: <TextSpan>[
                  TextSpan(
                    text:
                        "${authController.countryCode.value} ${authController.phoneNumber.value}.",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Constants.black,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  TextSpan(
                    text: ' Change phone number?',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Constants.secondaryColor,
                      fontFamily: 'Poppins',
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.back();
                      },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pinCodeTextField() {
    return PinCodeTextField(
      appContext: context,
      length: 6,
      animationType: AnimationType.fade,
      autovalidateMode: AutovalidateMode.disabled,
      validator: (value) {
        if (value!.length != 6) {
          return 'Enter Valid Pin';
        }
        return null;
      },
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.normal,
      ),
      autoFocus: true,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(16),
        fieldHeight: 50,
        fieldWidth: 50,
        activeFillColor: Constants.secondaryColor,
        inactiveFillColor: Colors.blue.withOpacity(0.1),
        inactiveColor: Colors.blue.withOpacity(0.1),
        activeColor: Colors.blue.withOpacity(0.1),
        selectedFillColor: Colors.blue.withOpacity(0.1),
        selectedColor: Colors.blue.withOpacity(0.1),
      ),
      errorTextSpace: 24,
      cursorColor: Constants.black,
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      keyboardType: TextInputType.number,
      // boxShadows: StyleUtil.primaryShadowLight(),
      onCompleted: (v) {
        debugPrint("Completed");
      },
      onChanged: (value) {
        _otp = value;
        setState(() {});
      },
    );
  }

  Widget _resendCodeText() {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isShowTimer)
            RichText(
              text: TextSpan(
                text: 'Resend code after ',
                style: TextStyle(
                  color: Constants.black,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins',
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: "00:$_start",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Constants.secondaryColor,
                      fontFamily: 'Poppins',
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Get.back();
                      },
                  ),
                ],
              ),
            ),
          if (!isShowTimer)
            TextButton(
              onPressed: () {
                _start = 60;
                startTimer();
                verifyPhone();
              },
              child: Text(
                'Resend',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Constants.secondaryColor,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _button() {
    return SizedBox(
      width: double.infinity,
      child: PrimaryButton(onPressed: _next, title: 'Verify'),
    );
  }

  void _next() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_otp!.length == 6) {
      _signInWithPhoneNumber(_otp!);
    } else {
      SnackBarUtil.showSnackBar('Enter Correct OTP'.tr);
    }
  }

  void _signInWithPhoneNumber(String smsCode) async {
    _authCredential = PhoneAuthProvider.credential(
        verificationId: actualCode!, smsCode: smsCode);

    debugPrint('authCredentials: $_authCredential');

    firebaseAuth.signInWithCredential(_authCredential!).catchError((error) {
      debugPrint('error in signing with creds: $error');

      SnackBarUtil.showSnackBar('Please enter correct OTP');
    }).then((result) {
      debugPrint('result : $result');

      if (result.user != null) {
        Get.to(() => const HomeScreen());
      }
    });
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);

    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            isShowTimer = false;
            timer.cancel();
          });
        } else {
          setState(() {
            isShowTimer = true;
            _start--;
          });
        }
      },
    );
  }

  Future<void> verifyPhone() async {
    codeSent(String verificationId, [int? forceResendingToken]) async {
      actualCode = verificationId;
      debugPrint(
          'Code sent to ${authController.countryCode.value}${authController.phoneNumber.value.trim()}');

      SnackBarUtil.showSnackBar(
          "Enter the code sent to ${authController.countryCode.value}${authController.phoneNumber.value.trim()}");
    }

    codeAutoRetrievalTimeout(String verificationId) {
      // actualCode = verificationId;

      debugPrint("Firebase otp auto retrive time out");
    }

    verificationFailed(authException) {
      debugPrint("authException.message: ${authException.message}");

      if (authException.message!.contains('not authorized')) {
        SnackBarUtil.showSnackBar('Something has gone wrong, please try later');
      } else if (authException.message!.contains('Network')) {
        SnackBarUtil.showSnackBar(
            'Please check your internet connection and try again');
      } else {
        SnackBarUtil.showSnackBar('Something has gone wrong, please try later');
      }
    }

    verificationCompleted(AuthCredential auth) {
      debugPrint('Auto retrieving verification code');
      // _authCredential = auth;
      // firebaseAuth.signInWithCredential(_authCredential!).then((value) {
      //   if (value.user != null) {
      //     _goToPasswordSetupPage();
      //   } else {
      //     SnackBarUtil.showSnackBar('Invalid OTP');
      //   }
      // }).catchError((error) {
      //   SnackBarUtil.showSnackBar('Something has gone wrong, please try later');
      // });
    }

    debugPrint(
        "OTP send start ${authController.countryCode.value}${authController.phoneNumber.value.trim()}");

    return firebaseAuth.verifyPhoneNumber(
        phoneNumber:
            "${authController.countryCode.value}${authController.phoneNumber.value.trim()}",
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }
}
