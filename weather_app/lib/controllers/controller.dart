import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/weather_data/weather_data.dart';
import 'package:weather_app/api/fetch_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/models/fake_data.dart';

class MyTheme extends GetxController {
  // initializing with the current theme of the device
  Rx<ThemeMode> currentTheme = ThemeMode.system.obs;

  // function to switch between themes
  void switchTheme() {
    currentTheme.value = currentTheme.value == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
  }
}

class GlobalController extends GetxController {
  final RxBool _isLoading = true.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxDouble temp = 0.0.obs;
  final RxDouble humidity = 0.0.obs;
  final RxDouble windspeed = 0.0.obs;
  final RxDouble cloudcover = 0.0.obs;
  final MyTheme myTheme = Get.put(MyTheme());
  final _weatherData = WeatherData().obs;
  RxList<String> units = ['C', 'km'].obs;
  static String key = 'weather_data';

  bool get loading => _isLoading.value;
  double get getLatitude => _latitude.value;
  double get getLongitude => _longitude.value;
  WeatherData get weatherData => _weatherData.value;

  @override
  void onInit() {
    super.onInit();
    if (_isLoading.isTrue) getLocation();
  }

  void switchTheme() {
    myTheme.switchTheme();
    Get.changeThemeMode(myTheme.currentTheme.value);
  }

  getLocation() async {
    bool isLocationServiceEnabled;
    LocationPermission locationPermission;

    // Check Location Service
    isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationServiceEnabled) {
      return Future.error('Error: Location Service not enabled');
    }

    // Check permissions
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error('Error: Permissions are deniedForever');
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error('Error: Permission is denied');
      }
    }

    // Get current Location
    bool isDataAvailable = await checkDataAvailable();
    try {
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((value) {
        // Update our data Location
        _longitude.value = value.longitude;
        _latitude.value = value.latitude;
        print(isDataAvailable);

        if (!isDataAvailable) {
          // try {
          //   FetchData()
          //       .processData(_latitude.value, _longitude.value)
          //       .then((value) async {
              print('nice');
              _weatherData.value = WeatherData.fromJson(fake_data);
              print('not nice');
              // _weatherData.value = value;
              temp.value = _weatherData.value.current?.temp ?? 0.0;
              humidity.value = _weatherData.value.current?.humidity ?? 0.0;
              windspeed.value = _weatherData.value.current?.windspeed ?? 0.0;
              cloudcover.value = _weatherData.value.current?.cloudcover ?? 0.0;
              print(
                  'celsiusToFahrenheit ${weatherData.celsiusToFahrenheit(temp.value)}');
              // await saveToPreferences();
              _isLoading.value = false;
        //     });
        //   } catch (e) {
        //     return Future.error('Error getting weather data: $e');
        //   }
        // } else {
        //   loadFromPreferences();
        }
      });
    } catch (e) {
      return Future.error('Error getting location: $e');
    }
  }

  Future<bool> checkDataAvailable() async {
    WeatherData? check;
    print('before');
    try {
      check = await loadFromPreferences();
    } catch (e) {
      print('not safe in 102');
    }
    print('safe');
    return check != null;
  }

  // Save WeatherData to SharedPreferences
  Future<void> saveToPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, _weatherData.toJson().toString());
  }

  // Load WeatherData from SharedPreferences
  static Future<WeatherData?> loadFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);
    if (jsonString != null) {
      final Map<String, dynamic> map =
          Map<String, dynamic>.from(json.decode(jsonString));
      return WeatherData.fromJson(map);
    }
    return null;
  }
}
