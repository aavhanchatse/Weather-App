import 'dart:convert';

import 'package:weather_app/models/forcast_data_model.dart';
import 'package:weather_app/models/weather_data_model.dart';

import '../app_constants/api_path.dart';
import '../utils/api_methods.dart';

class MasterRepo {
  final API _api = API();

  Future<WeatherData?> getWeatherData(double lat, double long) async {
    Map<String, String> headers = {
      'X-RapidAPI-Key': ApiPath.rapidApiKey,
      'X-RapidAPI-Host': 'open-weather13.p.rapidapi.com',
    };

    final response =
        await _api.getMethod("${ApiPath.getWeatherData}$lat/$long", headers);

    Map<String, dynamic> map = jsonDecode(response.body);

    return WeatherData.fromJson(map);
  }

  Future<ForcastData?> getWeatherForcastData(double lat, double long) async {
    Map<String, String> headers = {
      'X-RapidAPI-Key': ApiPath.rapidApiKey,
      'X-RapidAPI-Host': 'open-weather13.p.rapidapi.com',
    };

    final response = await _api.getMethod(
        "${ApiPath.getWeatherForcastData}$lat/$long", headers);

    Map<String, dynamic> map = jsonDecode(response.body);

    return ForcastData.fromJson(map);
  }
}
