import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/controllers/theme_controller.dart';
import 'package:weather_app/models/city_service.dart';
import 'package:weather_app/models/geonames.dart';
import 'package:weather_app/models/weather_data/weather_data.dart';

class GlobalController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxBool changeCity = false.obs;
  final RxBool isDark = false.obs;
  final RxDouble width = 0.0.obs;
  final RxInt cardIndex = 0.obs;
  final MyTheme myTheme = Get.put(MyTheme());
  final Rx<DateTime> currentTime = DateTime.now().obs;
  final Rx<WeatherData> weatherData = WeatherData().obs;
  final RxList<String> units = ['C', 'km'].obs;
  final RxString city = ''.obs;
  final Rx<Geoname> newcity = Geoname().obs;
  final cityService = CityService('koruzed');
  final Rx<GlobalKey<ScaffoldState>> scaffoldKey =
      GlobalKey<ScaffoldState>().obs;
  final RxString dateTime = ''.obs;

  int get currentHourTime => currentTime.value.hour;

  @override
  void onInit() {
    super.onInit();
    dateTime.value = DateFormat('yMMMMd').format(currentTime.value);
    cardIndex.value = currentHourTime;
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

    try {
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((value) {
        print('lat : ${value.latitude} | log : ${value.longitude}');
        fetchData(value.latitude, value.longitude);
      });
    } catch (e) {
      return Future.error('Error getting location: $e');
    }
  }

  getNewLocation() async {
    fetchData(newcity.value.lat!, newcity.value.lng!);
    city.value = newcity.value.name!;
    changeCity.value = false;
  }

  Future<void> fetchData(double lat, double log) async {
    print('fetch data');
    try {
      weatherData.value.processData(lat, log).then((value) async {
        weatherData.value = value;
        isLoading.value = false;
      });
    } catch (e) {
      return Future.error('Error getting weather data: $e');
    }
    print('safe -> ${changeCity.value}');
    if (changeCity.value == false)
      city.value = await cityService.searchCitiesByLatLog(lat, log);
    return Future.delayed(const Duration(seconds: 0));
  }
}
