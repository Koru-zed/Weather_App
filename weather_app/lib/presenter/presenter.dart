import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/presenter/theme_controller.dart';
import 'package:weather_app/models/city_service.dart';
import 'package:weather_app/models/geonames.dart';
import 'package:weather_app/models/weather_data/weather_data.dart';

class GlobalPresenter extends GetxController {
  final RxBool isLoading = true.obs;
  final RxBool isEnable = true.obs;
  final RxBool nowCity = true.obs;
  final RxBool changeCity = false.obs;
  final RxBool isDark = false.obs;
  final RxBool showMore = false.obs;
  final RxDouble width = 0.0.obs;
  final RxInt cardHourIndex = 0.obs;
  final RxInt cardDayIndex = 0.obs;
  // final RxInt index = 0.obs;
  final MyTheme myTheme = Get.put(MyTheme());
  final Rx<DateTime> currentTime = DateTime.now().obs;
  final Rx<WeatherData> weatherData = WeatherData().obs;
  final RxList<String> unit = ['C', 'km'].obs;
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
    cardHourIndex.value = currentHourTime;
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
      nowCity.value = false;
      print('Error: Location Service not enabled');
      return;
    }
    // Check permissions
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.deniedForever) {
      nowCity.value = false;
      print('Error: Permissions are deniedForever');
      return;
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        nowCity.value = false;
        print('Error: Permissions are denied');
        return;
      }
    }

    try {
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((value) {
        fetchData(value.latitude, value.longitude);
      });
    } catch (e) {
      nowCity.value = false;
      return print('Error getting location: $e');
    }
    print('all good');
  }

  getNewLocation() async {
    if (newcity.value.countryName != null) {
      await fetchData(newcity.value.lat!, newcity.value.lng!);
      city.value = newcity.value.name!;
      changeCity.value = false;
    }
  }

  bool checkRefresh() {
    final DateTime currentTimeNow = DateTime.now();
    if (currentTimeNow.day == currentTime.value.day &&
        weatherData.value.address != null) {
      if (currentTimeNow.hour != currentTime.value.hour) {
        currentTime.value = currentTimeNow;
      }
      print(' no my friend object');
      return false;
    }
    return true;
  }

  Future<void> fetchData(double lat, double log) async {
    try {
      weatherData.value.processData(lat, log, 0).then((value) async {
        weatherData.value = value;
        isLoading.value = false;
      }).catchError((err) {
        print('Error getting weather data: $err');
      });
    } catch (err) {
      print('Error getting weather data: $err');
    }
    if (changeCity.value == false) {
      city.value = await cityService.searchCitiesByLatLog(lat, log);
    }
    return Future.delayed(const Duration(seconds: 0));
  }
}
