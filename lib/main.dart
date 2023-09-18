import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:weather_app/controllers/auth_controller.dart';
import 'package:weather_app/view/screens/login_screen.dart';

import 'controllers/home_screen_controller.dart';
import 'firebase_options.dart';
import 'utils/size_config.dart';
import 'view/widgets/internet_subscription_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeScreenController());
    Get.put(AuthController());

    return Container(
      color: Colors.white,
      child: Center(
        child: Material(
          elevation: 20,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return OrientationBuilder(
                  builder: (BuildContext context2, Orientation orientation) {
                SizeConfig.init(constraints, orientation);

                return GetMaterialApp(
                  title: "Weather Tracker",
                  useInheritedMediaQuery: true,
                  debugShowCheckedModeBanner: false,
                  defaultTransition: GetPlatform.isIOS
                      ? Transition.cupertino
                      : Transition.rightToLeft,
                  home: const Stack(
                    children: [
                      LoginScreen(),
                      NoInternetSubscriptionWidget(),
                    ],
                  ),
                );
              });
            }),
          ),
        ),
      ),
    );
  }
}
