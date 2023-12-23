import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

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
  final MyTheme myTheme = Get.put(MyTheme());

  bool get loading => _isLoading.value;
  double get getLatitude => _latitude.value;
  double get getLongitude => _longitude.value;

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
    if (locationPermission == LocationPermission.deniedForever)
      return Future.error('Error: Permissions are deniedForever');
    else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied)
        return Future.error('Error: Permission is denied');
    }

    // Get current Location
    try {
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((value) {
        // Update our data Location
        _longitude.value = value.longitude;
        _latitude.value = value.latitude;
        _isLoading.value = false;
      });
    } catch (e) {
      return Future.error('Error getting location: $e');
    }
  }
}
