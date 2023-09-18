import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:weather_app/models/forcast_data_model.dart';
import 'package:weather_app/models/weather_data_model.dart';
import 'package:weather_app/utils/date_util.dart';

import '../repo/master_repo.dart';
import '../utils/default_snackbar_util.dart';
import '../utils/internet_util.dart';
import '../utils/location_util.dart';

class HomeScreenController extends GetxController {
  var weatherData = WeatherData().obs;
  var forcastData = ForcastData().obs;
  var loading = true.obs;
  var loading2 = true.obs;
  var datesList = <String>[].obs;
  var listOfElements = <ListElement>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getCurrentLocation();
  }

  void getCurrentLocation() async {
    final LocationData? location = await LocationUtils.getCurrentLocation();

    if (location != null) {
      fetchWeatherData(location);
      fetchWeatherForcastData(location);
    }
  }

  void fetchWeatherData(LocationData locationData) async {
    final isInternet = await InternetUtil.isInternetConnected();
    loading.value = true;

    if (isInternet) {
      try {
        final WeatherData? result = await MasterRepo()
            .getWeatherData(locationData.latitude!, locationData.longitude!);

        if (result != null) {
          setValues(result);
        } else {
          loading.value = false;
          SnackBarUtil.showSnackBar(
              "Couldn't fetch data. Try after some time.");
        }
      } catch (error) {
        loading.value = false;
        SnackBarUtil.showSnackBar('Something went wrong');
        debugPrint('error: $error');
      }
    } else {
      SnackBarUtil.showSnackBar('No Internet Connected');
    }
  }

  void fetchWeatherForcastData(LocationData locationData) async {
    final isInternet = await InternetUtil.isInternetConnected();
    loading2.value = true;

    if (isInternet) {
      try {
        final ForcastData? result = await MasterRepo().getWeatherForcastData(
            locationData.latitude!, locationData.longitude!);

        if (result != null) {
          setForcastData(result);
        } else {
          loading2.value = false;
          SnackBarUtil.showSnackBar(
              "Couldn't fetch data. Try after some time.");
        }
      } catch (error) {
        loading2.value = false;
        SnackBarUtil.showSnackBar('Something went wrong');
        debugPrint('error: $error');
      }
    } else {
      SnackBarUtil.showSnackBar('No Internet Connected');
    }
  }

  void setValues(WeatherData result) {
    weatherData.value = result;

    loading.value = false;
  }

  void setForcastData(ForcastData result) {
    forcastData.value = result;

    List<String> dateList = [];

    if (result.list != null) {
      for (var element in result.list!) {
        final date = DateUtil.getDateAndMonthFromEpoch(element.dt);

        element.dt = date;

        dateList.add(date);
      }

      dateList = dateList.toSet().toList();
      debugPrint('dateList: $dateList');
    }

    datesList.value = dateList;

    loading2.value = false;
  }

  void getDateList(String date) {
    List<ListElement> list = [];

    if (forcastData.value.list != null) {
      listOfElements.clear();

      for (var element in forcastData.value.list!) {
        if (element.dt == date) {
          list.add(element);
        }
      }

      listOfElements.value = list;
    }
  }
}
