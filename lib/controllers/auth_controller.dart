import 'package:get/get.dart';

class AuthController extends GetxController {
  var countryCode = '+91'.obs;
  var countryEmoji = '🇮🇳'.obs;
  var phoneNumber = ''.obs;

  void resetAll() {
    countryCode = '+91'.obs;
    countryEmoji = '🇮🇳'.obs;
    phoneNumber = ''.obs;
  }
}
