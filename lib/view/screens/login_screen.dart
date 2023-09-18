import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/app_constants/assets_paths.dart';
import 'package:weather_app/controllers/auth_controller.dart';
import 'package:weather_app/utils/default_snackbar_util.dart';
import 'package:weather_app/utils/gesturedetector_util.dart';
import 'package:weather_app/utils/internet_util.dart';
import 'package:weather_app/view/screens/otp_screen.dart';
import 'package:weather_app/view/widgets/primary_button.dart';

import '../../app_constants/constants.dart';
import '../../utils/size_config.dart';
import '../../utils/style_utils.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GestureDetectorUtil.onScreenTap();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: 100.h,
            width: 100.w,
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    _headingImage(),
                    _headingWidget(),
                  ],
                ),
                _phoneNumberContainer(),
                Column(
                  children: [
                    _button(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _headingImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AssetsPath.loginLogo,
          width: 80.w,
        ),
      ],
    );
  }

  Widget _headingWidget() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Login'.tr,
            style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins'),
          ),
          SizedBox(height: 0.7.h),
          Text(
            'A verification code will be sent to\n the phone number you enter'
                .tr,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 1.5.t, fontFamily: 'Poppins'),
          ),
        ],
      ),
    );
  }

  Widget _phoneNumberContainer() {
    return Container(
      margin: EdgeInsets.only(top: 4.w),
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(2.h)),

      // decoration: StyleUtil.defaultBoxDecoration(),
      child: Row(
        children: [
          _countryCodePickerField(),
          SizedBox(width: 3.w),
          _phoneNumberTextField(),
        ],
      ),
    );
  }

  Widget _countryCodePickerField() {
    final AuthController authController = Get.find<AuthController>();

    return Obx(
      () => InkWell(
        onTap: _showCountryCodePickerBottomsheet,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              authController.countryEmoji.value,
              style: TextStyle(fontSize: 2.5.t),
            ),
            const SizedBox(width: 5),
            Text(authController.countryCode.value),
          ],
        ),
      ),
    );
  }

  Widget _phoneNumberTextField() {
    final AuthController authController = Get.find<AuthController>();

    return Expanded(
      child: TextFormField(
        keyboardAppearance: Brightness.light,
        initialValue: authController.phoneNumber.value,
        onChanged: (value) {
          authController.phoneNumber.value = value;
        },
        // validator: (String? value) {
        //   if (value!.trim().isEmpty) {
        //     return 'enter_valid_number'.tr;
        //   }
        //   return null;
        // },
        maxLength: 10,
        cursorColor: Constants.black,
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          counterText: '',
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
          hintText: 'Phone Number'.tr,
          hintStyle: TextStyle(color: Constants.black, fontSize: 2.t),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }

  void _showCountryCodePickerBottomsheet() {
    final AuthController authController = Get.find<AuthController>();

    showCountryPicker(
      context: Get.context!,
      showPhoneCode: true,
      onSelect: (Country country) {
        authController.countryCode.value = country.countryCode;
        authController.countryEmoji.value = country.flagEmoji;
      },
      countryListTheme: CountryListThemeData(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32.0),
          topRight: Radius.circular(32.0),
        ),
        inputDecoration: InputDecoration(
          counterText: '',
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
          hintText: 'Look for a country',
          prefixIcon: Icon(
            Icons.search,
            color: Constants.black,
          ),
          hintStyle: TextStyle(
            color: Constants.black,
            fontSize: 1.8.t,
          ),
          fillColor: Constants.white,
          filled: true,
          focusedBorder: StyleUtil.formTextFieldInputBorder(),
          enabledBorder: StyleUtil.formTextFieldInputBorder(),
          border: StyleUtil.formTextFieldInputBorder(),
          errorBorder: StyleUtil.formTextFieldInputBorder(),
          disabledBorder: StyleUtil.formTextFieldInputBorder(),
        ),
      ),
    );
  }

  Widget _button() {
    return SizedBox(
      width: double.infinity,
      child: PrimaryButton(onPressed: _login, title: 'Send OTP'),
    );
  }

  void _login([bool isFromSocialMediaLogin = false, String email = ""]) async {
    FocusManager.instance.primaryFocus!.unfocus();

    final AuthController authController = Get.find<AuthController>();

    if (!isFromSocialMediaLogin) {
      if (authController.phoneNumber.value.isEmpty ||
          authController.phoneNumber.value.length < 10) {
        SnackBarUtil.getToast('Enter valid phone number');
        return;
      }
    }

    final isInternet = await InternetUtil.isInternetConnected();

    if (isInternet) {
      try {
        Get.to(() => const OTPScreen());
      } catch (error) {
        SnackBarUtil.showSnackBar('Something went wrong');
        debugPrint('error: $error');
      }
    } else {
      SnackBarUtil.showSnackBar("No Internet Available");
    }
  }
}
