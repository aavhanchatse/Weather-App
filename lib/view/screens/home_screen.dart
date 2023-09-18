import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/utils/date_util.dart';
import 'package:weather_app/utils/size_config.dart';
import 'package:weather_app/view/screens/forcast_screen.dart';
import 'package:weather_app/view/widgets/custom_container.dart';

import '../../app_constants/constants.dart';
import '../../controllers/home_screen_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              _currentWeatherWidget(),
              SizedBox(height: 6.w),
              _forcastWeatherWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _currentWeatherWidget() {
    final HomeScreenController controller = Get.find<HomeScreenController>();

    return Obx(
      () => controller.loading.value == true
          ? SizedBox(
              height: 50.h,
              width: double.infinity,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.blue.withOpacity(0.1),
                    ),
                    height: 40.h,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          controller.weatherData.value.weather!.first.main ??
                              "",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 35,
                          ),
                        ),
                        SizedBox(height: 4.w),
                        Text(
                          DateUtil.getDateFromEpoch(
                              controller.weatherData.value.dt ?? 0),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          controller.weatherData.value.name ?? "",
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Lat Long: ${controller.weatherData.value.coord!.lat ?? ""} | ${controller.weatherData.value.coord!.lon ?? ""}",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomContainer(
                          title: "Temp",
                          value:
                              "${controller.weatherData.value.main!.temp ?? ""}"),
                      SizedBox(width: 4.w),
                      CustomContainer(
                          title: "Pressure",
                          value:
                              "${controller.weatherData.value.main!.pressure ?? ""}"),
                      SizedBox(width: 4.w),
                      CustomContainer(
                          title: "Humidity",
                          value:
                              "${controller.weatherData.value.main!.humidity ?? ""}"),
                    ],
                  ),
                  SizedBox(height: 4.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomContainer(
                          title: "Visibility",
                          value:
                              "${controller.weatherData.value.visibility ?? ""}"),
                      SizedBox(width: 4.w),
                      CustomContainer(
                          title: "Wind Speed",
                          value:
                              "${controller.weatherData.value.wind!.speed ?? ""}"),
                    ],
                  ),
                  // SizedBox(height: 4.w),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     CustomContainer(
                  //         title: "Sunrise",
                  //         value:
                  //             "${controller.weatherData.value.sys!.sunrise ?? ""}"),
                  //     SizedBox(width: 4.w),
                  //     CustomContainer(
                  //         title: "Sunset",
                  //         value:
                  //             "${controller.weatherData.value.sys!.sunset ?? ""}"),
                  //   ],
                  // ),
                ],
              ),
            ),
    );
  }

  Widget _forcastWeatherWidget() {
    final HomeScreenController controller = Get.find<HomeScreenController>();

    return Obx(
      () => controller.loading2.value == true
          ? SizedBox(
              height: 50.h,
              width: double.infinity,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 4.w),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    "Forcast",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
                SizedBox(height: 4.w),
                SizedBox(
                  height: 15.h,
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.datesList.length,
                    itemBuilder: (context, index) {
                      final item = controller.datesList[index];

                      return InkWell(
                        onTap: () {
                          controller.getDateList(item);
                          Get.to(() => ForcastScreen(date: item));
                        },
                        child: Container(
                          height: double.infinity,
                          width: 25.w,
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 3.w),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 35,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(width: 3.w);
                    },
                  ),
                ),
                SizedBox(height: 8.w),
              ],
            ),
    );
  }
}
