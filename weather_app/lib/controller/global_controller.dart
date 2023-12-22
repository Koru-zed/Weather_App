part of './controller_library.dart';

class GlobalController extends GetxController {
  final RxBool _isLoading = true.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxString _theme = 'dark'.obs;

  bool get loading => _isLoading.value;
  double get getLatitude => _latitude.value;
  double get getLongitude => _longitude.value;

  Color getTextColor() => _theme.value == 'dark' ? Colors.white : Colors.black;
  Color getThemeColor() => _theme.value == 'dark'
      ? const Color.fromARGB(255, 31, 37, 45)
      : Colors.white;
  Color getTextColorTwo() =>
      _theme.value == 'dark' ? Colors.grey.shade400 : Colors.grey.shade700;

  @override
  void onInit() {
    super.onInit();
    if (_isLoading.isTrue) getLocation();
  }

  void setTheme() {
    print(_theme.value);
    _theme.value = _theme.value == 'dark' ? 'light' : 'dark';
    print('** change theme **');
    update(); // Trigger UI update
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
