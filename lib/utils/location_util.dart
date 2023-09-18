import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart' as locationData;
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_app/app_constants/constants.dart';
import 'package:weather_app/utils/default_snackbar_util.dart';
import 'package:weather_app/utils/size_config.dart';

class LocationUtils {
  static Future<locationData.LocationData?>? getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permission;

    locationData.Location locationDatum = locationData.Location();

    // Test if location services are enabled.
    serviceEnabled = await locationDatum.serviceEnabled();
    // serviceEnabled = await Geolocator.isLocationServiceEnabled();
    debugPrint('serviceEnabled: $serviceEnabled');

    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      debugPrint('Location services are disabled, requesting again');

      serviceEnabled = await locationDatum.requestService();

      debugPrint('requested again: $serviceEnabled');
      if (!serviceEnabled) {
        return null;
      }

      // return null;
      // return Future.error('Location services are disabled.');
    }

    permission = await Permission.location.status;
    // permission = await Geolocator.checkPermission();
    debugPrint('permission: $permission');

    if (permission == PermissionStatus.denied) {
      permission = await Permission.location.request();
      if (permission == PermissionStatus.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        debugPrint('Location permissions are denied');

        SnackBarUtil.showSnackBar('Location permission denied');
        return null;
        // return Future.error('Location permissions are denied');
      }
    }

    if (permission == PermissionStatus.permanentlyDenied) {
      // Permissions are denied forever, handle appropriately.
      debugPrint(
          'Location permissions are permanently denied, we cannot request permissions.');

      SnackBarUtil.showSnackBar(
        'Location permission disabled',
        actionButton: TextButton(
          onPressed: () {
            AppSettings.openLocationSettings();
          },
          child: Text(
            'App Settings',
            style: TextStyle(color: Constants.white, fontSize: 1.8.t),
          ),
        ),
      );
      return null;
      // return Future.error(
      //     'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    final position = await locationDatum.getLocation();
    return position;
  }
}
