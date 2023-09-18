import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/app_constants/constants.dart';
import 'package:weather_app/controllers/home_screen_controller.dart';
import 'package:weather_app/utils/date_util.dart';
import 'package:weather_app/utils/size_config.dart';
import 'package:weather_app/view/widgets/custom_container.dart';

class ForcastScreen extends StatelessWidget {
  final String date;
  const ForcastScreen({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    final HomeScreenController controller = Get.find<HomeScreenController>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.withOpacity(0.1),
          title: Text(
            date,
            style: TextStyle(color: Constants.black),
          ),
          elevation: 0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Constants.black),
              onPressed: () {
                Get.back();
              }),
        ),
        backgroundColor: Constants.white,
        body: ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.all(4.w),
          itemCount: controller.listOfElements.length,
          itemBuilder: (context, index) {
            final item = controller.listOfElements[index];

            return Container(
              width: double.infinity,
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text(
                    DateUtil.getDisplayFormatTime(item.dtTxt!),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    item.weather!.first.main!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(height: 4.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomContainer(
                          title: "Temp", value: "${item.main!.temp ?? ""}"),
                      SizedBox(width: 4.w),
                      CustomContainer(
                          title: "Pressure",
                          value: "${item.main!.pressure ?? ""}"),
                      SizedBox(width: 4.w),
                      CustomContainer(
                          title: "Humidity",
                          value: "${item.main!.humidity ?? ""}"),
                    ],
                  ),
                  SizedBox(height: 4.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomContainer(
                          title: "Visibility",
                          value: "${item.visibility ?? ""}"),
                      SizedBox(width: 4.w),
                      CustomContainer(
                          title: "Wind Speed",
                          value: "${item.wind!.speed ?? ""}"),
                    ],
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 4.w);
          },
        ),
      ),
    );
  }
}
