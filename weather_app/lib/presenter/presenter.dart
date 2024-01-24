import 'dart:async';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/presenter/theme_controller.dart';
import 'package:weather_app/models/city_service.dart';
import 'package:weather_app/models/geonames.dart';
import 'package:weather_app/models/weather_data/weather_data.dart';

class GlobalPresenter extends GetxController with WidgetsBindingObserver {
  // Check Conection
  final RxBool isConnect = true.obs;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  // Storage
  final GetStorage box = GetStorage();

  // Timer
  Timer? _hourlyTimer;

  final RxBool isLoading = true.obs;
  final RxBool isEnable = true.obs;
  final RxBool changeCity = false.obs;
  final RxBool isDark = false.obs;
  final RxBool showMore = false.obs;
  final RxDouble width = 0.0.obs;
  final RxDouble height = 0.0.obs;
  final RxInt cardHourIndex = 0.obs;
  final MyTheme myTheme = Get.put(MyTheme());
  final Rx<DateTime> currentTime = DateTime.now().obs;
  final Rx<WeatherData> weatherData = WeatherData().obs;
  final RxInt unit = 0.obs;
  final Rx<Geoname> newcity = Geoname().obs;
  final cityService = CityService('koruzed');
  final Rx<GlobalKey<ScaffoldState>> scaffoldKey =
      GlobalKey<ScaffoldState>().obs;
  final RxString dateTime = ''.obs;

  int get currentHourTime => currentTime.value.hour;

  @override
  void onInit() {
    super.onInit();

    initConnectivity();
    dateTime.value = DateFormat('yMMMMd').format(currentTime.value);
    _scheduleHourlyTimer();
    cardHourIndex.value = currentHourTime;

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((event) {
      isConnect.value = checkConnection(event);
    });

    WidgetsBinding.instance.addObserver(this);
    if (loadWeatherData() == false) {
      if (getGeoLocatore()) {
        getLocation();
      } else {
        isEnable.value = false;
      }
    }
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    saveWeatherData();

    _connectivitySubscription.cancel();
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Save user data only when the app is paused (closed)
      saveWeatherData();
    }
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
      isConnect.value = checkConnection(result);
    } catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      isConnect.value = false;
    }
  }

  void _scheduleHourlyTimer() {
    const Duration hourly = Duration(hours: 1);

    _hourlyTimer = Timer.periodic(hourly, (Timer timer) {
      _checkHourChange();
    });
  }

  void _checkHourChange() {
    developer.log('check Hour Change');
    DateTime now = DateTime.now();
    if (now.hour != currentHourTime) {
      currentTime.value = now;
    }
  }

  // Check type of device
  bool getGeoLocatore() => kIsWeb
      ? true
      : switch (defaultTargetPlatform) {
          TargetPlatform.android => true,
          TargetPlatform.iOS => true,
          TargetPlatform.linux => false,
          TargetPlatform.windows => true,
          TargetPlatform.macOS => true,
          TargetPlatform.fuchsia => false
        };

  // Check Connection
  bool checkConnection(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none ||
        connectivityResult == ConnectivityResult.bluetooth) {
      return false;
    }
    return true;
  }

  // Save Weather Data
  void saveWeatherData() {
    box.write('weatherData', weatherData.value.toJson());
    developer.log('save Data');
  }

  // Load Weather Data
  bool loadWeatherData() {
    final Map<String, dynamic>? json =
        box.read<Map<String, dynamic>>('weatherData');
    if (json != null) {
      weatherData.value = WeatherData.fromJson(json);
      if (weatherData.value.getIndexofDay(currentTime.value) == -1) {
        return false;
      }
      isLoading.value = false;
      return true;
    }
    return false;
  }

  void switchTheme() {
    myTheme.switchTheme();
    Get.changeThemeMode(myTheme.currentTheme.value);
  }

  getLocation() async {
    bool isLocationServiceEnabled;
    LocationPermission locationPermission;

    if (isConnect.value == false) return;

    // Check Location Service
    isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationServiceEnabled) {
      isEnable.value = false;
      developer.log('Error: Location Service not enabled');
      return;
    }
    // Check permissions
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.deniedForever) {
      isEnable.value = false;
      developer.log('Error: Permissions are deniedForever');
      return;
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        isEnable.value = false;
        developer.log('Error: Permissions are denied');
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
      isEnable.value = false;
      return developer.log('Error getting location: $e');
    }
  }

  getNewLocation() async {
    if (isConnect.value == false) return;
    if (newcity.value.countryName != null) {
      await fetchData(newcity.value.lat!, newcity.value.lng!);
      weatherData.value.address!.value = newcity.value.name![0].toUpperCase() +
          newcity.value.name!.substring(1);
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
      developer.log(' no my friend');
      return false;
    }
    if (isConnect.value == false) return false;
    return true;
  }

  Future<void> fetchData(double lat, double log) async {
    if (isConnect.value == false) return;
    try {
      await weatherData.value.processData(lat, log, 0).then((value) async {
        weatherData.value = value;
      }).catchError((err) {
        developer.log('Error getting weather data: $err');
      });
    } catch (err) {
      developer.log('Error getting weather data: $err');
    }
    if (changeCity.value == false) {
      weatherData.value.address!.value =
          await cityService.searchCitiesByLatLog(lat, log);
    }
    weatherData.value.updateUnits(weatherData.value.units[unit.value], weatherData.value.units[0]);
    isLoading.value = false;
    return Future.delayed(const Duration(seconds: 0));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _hourlyTimer?.cancel();
  }
}
