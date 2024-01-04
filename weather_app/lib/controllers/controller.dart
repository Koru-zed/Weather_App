import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/geonames.dart';
import 'package:weather_app/models/weather_data/weather_data.dart';
import 'package:weather_app/api/fetch_data.dart';
import 'package:geocoding/geocoding.dart';
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
  final RxBool isLoading = true.obs;
  final RxBool changeCity = false.obs;
  final RxBool isDark = false.obs;
  final RxDouble width = 0.0.obs;
  final RxInt cardIndex = 0.obs;
  final MyTheme myTheme = Get.put(MyTheme());
  final Rx<DateTime> currentTime = DateTime.now().obs;
  final Rx<WeatherData> weatherData = WeatherData().obs;
  RxList<String> units = ['C', 'km'].obs;
  final RxString city = ''.obs;
  final Rx<Geoname> newcity = Geoname().obs;
  static String key = 'weather_data';
  final Rx<GlobalKey<ScaffoldState>> scaffoldKey =
      GlobalKey<ScaffoldState>().obs;

  int get currentHourTime => currentTime.value.hour;

  @override
  void onInit() {
    super.onInit();
    // weatherData.value = WeatherData.fromJson(fake_data);
    // isLoading.value = false;
    // if (isLoading.isTrue) getLocation();
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
    print('is => ${isDataAvailable}');
    try {
      print('yyyyyyyyyyyyyyyyyyy');
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((value) {
      // Update our data Location

      print('isDataAvailable = $isDataAvailable');

      if (!isDataAvailable) {
        // fetchData(51.5072, 0.1276);
        print('lat : ${value.latitude} | log : ${value.longitude}');
        fetchData(value.latitude, value.longitude);
      } else {
        loadFromPreferences();
      }
        });
    } catch (e) {
      return Future.error('Error getting location: $e');
    }
  }

  getNewLocation() async {
    print('object new +++');
    print('lat : ${newcity.value.lat!}, log : ${newcity.value.lng!}');
    fetchData(newcity.value.lat!, newcity.value.lng!);
  }

  Future<bool> checkDataAvailable() async {
    try {
      WeatherData? check = await loadFromPreferences();
      print('WeatherData');
      return check != null;
    } catch (e) {
      // Log or handle the error
      print('Error checking data availability: $e');
      return false;
    }
  }

  Future<void> fetchData(double lat, double log) async {
    try {
      FetchData().processData(lat, log).then((value) async {
        weatherData.value = value;
        try {
          List<Placemark> location = await placemarkFromCoordinates(lat, log);
          city.value = location[0].locality!;
          print('city : ${city.value}');
        } catch (e) {
          print("Error getting location: $e");
        }
        try {
          await saveToPreferences();
          print('save data');
        } catch (e) {
          print('Error saving data : $e');
        }
        isLoading.value = false;
        print('isLoading.value  = ${isLoading.value}');
      });
    } catch (e) {
      return Future.error('Error getting weather data: $e');
    }
    return Future.delayed(const Duration(seconds: 0));
  }

  // Save WeatherData to SharedPreferences
  Future<void> saveToPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, weatherData.toJson().toString());
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
