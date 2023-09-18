// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

// import '../../app_constants/constants.dart';
// import '../../utils/size_config.dart';
// import '../../utils/style_utils.dart';
// import '../widgets/custom_scaffold_body.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return CustomScaffoldBody(
//       body: Scaffold(
//         body: SingleChildScrollView(
//           child: Container(
//             height: 100.h,
//             width: 100.w,
//             padding: EdgeInsets.symmetric(horizontal: 6.w),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _logoWidget(),
//                 // SizedBox(height: 2.h),
//                 Column(
//                   children: [
//                     _headingImage(),
//                     _headingWidget(),
//                   ],
//                 ),
//                 _phoneNumberContainer(),
//                 // SizedBox(height: 4.h),
//                 _signInOptionsWidget(),
//                 // SizedBox(height: 4.h),
//                 Column(
//                   children: [
//                     _button(),
//                     _doctorLogin(),
//                   ],
//                 ),
//                 // SizedBox(height: 1.w),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _logoWidget() {
//     return Center(
//       child: Padding(
//         padding: EdgeInsets.only(top: 5.h),
//         child: Column(
//           children: [
//             Image.asset(
//               AssetsPath.pinkTreeLogo,
//               width: 37.w,
//             ),
//             SizedBox(
//               height: 1.2.h,
//             ),
//             Text(
//               'Be Lung Healthy'.tr,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   color: Constants.black,
//                   fontSize: 1.5.t,
//                   fontFamily: 'Poppins'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _headingImage() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Image.asset(
//           AssetsPath.loginImage,
//           width: 70.w,
//         ),
//       ],
//     );
//   }

//   Widget _headingWidget() {
//     return Center(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(
//             'Login'.tr,
//             style: const TextStyle(
//                 fontSize: 17,
//                 fontWeight: FontWeight.w500,
//                 fontFamily: 'Poppins'),
//           ),
//           SizedBox(height: 0.7.h),
//           Text(
//             'A verification code will be sent to\n the phone number you enter'
//                 .tr,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//                 color: Constants.primaryGrey,
//                 fontSize: 1.5.t,
//                 fontFamily: 'Poppins'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _phoneNumberContainer() {
//     return Container(
//       margin: EdgeInsets.only(top: 4.w),
//       padding: EdgeInsets.symmetric(horizontal: 4.w),
//       decoration: BoxDecoration(
//           color: Constants.primaryInputBgColor,
//           borderRadius: BorderRadius.circular(2.h)),

//       // decoration: StyleUtil.defaultBoxDecoration(),
//       child: Row(
//         children: [
//           _countryCodePickerField(),
//           SizedBox(width: 3.w),
//           _phoneNumberTextField(),
//         ],
//       ),
//     );
//   }

//   Widget _countryCodePickerField() {
//     final AuthController authController = Get.find<AuthController>();

//     return Obx(
//       () => InkWell(
//         onTap: _showCountryCodePickerBottomsheet,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Text(
//               authController.countryEmoji.value,
//               style: TextStyle(fontSize: 2.5.t),
//             ),
//             const SizedBox(width: 5),
//             Text(authController.countryCode.value),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _phoneNumberTextField() {
//     final AuthController authController = Get.find<AuthController>();

//     return Expanded(
//       child: TextFormField(
//         keyboardAppearance: Brightness.light,
//         initialValue: authController.phoneNumber.value,
//         onChanged: (value) {
//           authController.phoneNumber.value = value;
//         },
//         // validator: (String? value) {
//         //   if (value!.trim().isEmpty) {
//         //     return 'enter_valid_number'.tr;
//         //   }
//         //   return null;
//         // },
//         maxLength: 10,
//         cursorColor: Constants.black,
//         keyboardType: TextInputType.phone,
//         textInputAction: TextInputAction.next,
//         decoration: InputDecoration(
//           counterText: '',
//           contentPadding:
//               const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
//           hintText: 'Phone Number'.tr,
//           hintStyle: TextStyle(color: Constants.textGrey, fontSize: 2.t),
//           focusedBorder: InputBorder.none,
//           enabledBorder: InputBorder.none,
//           border: InputBorder.none,
//           errorBorder: InputBorder.none,
//           disabledBorder: InputBorder.none,
//         ),
//       ),
//     );
//   }

//   void _showCountryCodePickerBottomsheet() {
//     final AuthController authController = Get.find<AuthController>();

//     showCountryPicker(
//       context: Get.context!,
//       showPhoneCode: true,
//       onSelect: (Country country) {
//         authController.countryCode.value = country.countryCode;
//         authController.countryEmoji.value = country.flagEmoji;
//       },
//       countryListTheme: CountryListThemeData(
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(32.0),
//           topRight: Radius.circular(32.0),
//         ),
//         inputDecoration: InputDecoration(
//           counterText: '',
//           contentPadding:
//               const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
//           hintText: 'Look for a country',
//           prefixIcon: Icon(
//             Icons.search,
//             color: Constants.primaryGreyLight,
//           ),
//           hintStyle: TextStyle(
//             color: Constants.primaryGreyLight,
//             fontSize: 1.8.t,
//           ),
//           fillColor: Constants.primaryInputBgColor,
//           filled: true,
//           focusedBorder: StyleUtil.formTextFieldInputBorder(),
//           enabledBorder: StyleUtil.formTextFieldInputBorder(),
//           border: StyleUtil.formTextFieldInputBorder(),
//           errorBorder: StyleUtil.formTextFieldInputBorder(),
//           disabledBorder: StyleUtil.formTextFieldInputBorder(),
//         ),
//       ),
//     );
//   }

//   Widget _signInOptionsWidget() {
//     return Center(
//       child: Column(
//         children: [
//           Text(
//             'Or Sign In with'.tr,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//                 color: Constants.primaryGrey,
//                 fontSize: 1.5.t,
//                 fontFamily: 'Poppins'),
//           ),
//           SizedBox(height: 1.w),
//           SizedBox(
//             height: 5.h,
//             width: 50.w,
//             // color: Colors.grey,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 InkWell(
//                     onTap: () {
//                       final AuthController authController =
//                           Get.find<AuthController>();
//                       Authentication.signInWithGoogle(context: Get.context)
//                           .then((value) async {
//                         if (value != null &&
//                             value.email != null &&
//                             value.email!.isNotEmpty) {
//                           Get.find<UserController>().userData.value =
//                               UserData();
//                           Get.find<AuthController>().resetAll();

//                           authController.email.value = value.email!;
//                           authController.name.value =
//                               value.displayName!.split(" ").toList().first ??
//                                   "";
//                           authController.lastName.value =
//                               value.displayName!.split(" ").toList().last ?? "";
//                           authController.loginMode.value = "Google";
//                           debugPrint(
//                               "display_name :: " + (value.displayName ?? ""));
//                           _login(true, value.email ?? "");
//                         } else {
//                           SnackBarUtil.showSnackBar(
//                               "Cannot login with this Provider. Try Again later.");
//                         }
//                       });
//                     },
//                     child: _imageWidget(AssetsPath.googleIcon)),
//                 InkWell(
//                     onTap: () {
//                       final AuthController authController =
//                           Get.find<AuthController>();
//                       Authentication.signInWithFacebook().then((value) async {
//                         if (value != null &&
//                             value.email != null &&
//                             value.email!.isNotEmpty) {
//                           Get.find<UserController>().userData.value =
//                               UserData();
//                           Get.find<AuthController>().resetAll();

//                           authController.email.value = value.email!;
//                           authController.loginMode.value = "FB";
//                           _login(true, value.email ?? "");
//                         } else {
//                           SnackBarUtil.showSnackBar(
//                               "Cannot login with this Provider. Try Again later.");
//                         }
//                       });
//                     },
//                     child: _imageWidget(AssetsPath.fbIcon)),
//                 if (GetPlatform.isIOS) _imageWidget(AssetsPath.appleIcon),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget _imageWidget(String image) {
//     return SizedBox(
//       width: 7.w,
//       height: 7.h,
//       child: Image.asset(
//         image,
//       ),
//     );
//   }

//   Widget _button() {
//     return SizedBox(
//       width: double.infinity,
//       child: PrimaryButton(onPressed: _login, title: 'Send OTP'),
//     );
//   }

//   Widget _doctorLogin() {
//     return Center(
//       child: TextButton(
//         onPressed: () {
//           Get.to(() => const DoctorLoginScreen());
//         },
//         child: Text(
//           'Doctors Login'.tr,
//           textAlign: TextAlign.center,
//           style: TextStyle(
//               color: Constants.primaryColor,
//               fontSize: 1.5.t,
//               fontFamily: 'Poppins'),
//         ),
//       ),
//     );
//   }

//   void _login([bool isFromSocialMediaLogin = false, String email = ""]) async {
//     FocusManager.instance.primaryFocus!.unfocus();

//     final AuthController authController = Get.find<AuthController>();

//     if (!isFromSocialMediaLogin) {
//       if (authController.phoneNumber.value.isEmpty ||
//           authController.phoneNumber.value.length < 10) {
//         SnackBarUtil.getToast('Enter valid phone number');
//         return;
//       }
//     }

//     ProgressDialog.showProgressDialog(Get.context!);
//     final isInternet = await InternetUtil.isInternetConnected();

//     if (isInternet) {
//       try {
//         Map payload = {
//           if (!isFromSocialMediaLogin)
//             'username':
//                 "${authController.countryCode.value}${authController.phoneNumber.value.trim()}",
//           if (isFromSocialMediaLogin) 'username': email
//         };

//         final result = await AuthRepo().loginUser(payload);
//         Get.back();

//         if (result.status == true) {
//           if (isFromSocialMediaLogin) {
//             _goToPasswordSetupPage(result.data!);
//           } else {
//             Get.to(() => OTPScreen(userData: result.data));
//           }
//         } else if (result.status == false &&
//             result.message == "Patient not found!") {
//           if (isFromSocialMediaLogin) {
//             _goToPasswordSetupPage(null);
//           } else {
//             Get.to(() => const OTPScreen());
//           }
//         } else {
//           SnackBarUtil.showSnackBar(result.message!);
//         }
//       } catch (error) {
//         Get.back();
//         SnackBarUtil.showSnackBar('Something went wrong');
//         debugPrint('error: $error');
//       }
//     } else {
//       Get.back();
//       SnackBarUtil.showSnackBar("No Internet Available");
//     }
//   }

//   void _goToPasswordSetupPage(UserData? userData) {
//     if (userData != null) {
//       _storeData(userData);
//       Get.find<AuthController>().resetAll();
//       Get.offAll(() => const NavBar());
//     } else {
//       Get.to(() => const RegistrationScreen(
//             isFromSocialMediaLogin: true,
//           ));
//     }
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
// }
