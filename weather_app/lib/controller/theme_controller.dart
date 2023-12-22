part of './controller_library.dart';

enum ThemeType {
  light,
  dark,
}

class ThemeController extends GetxController {
  final RxString _theme = 'dark'.obs;

  Color getTextColor() => _theme.value == 'dark' ? Colors.white : Colors.black;
  Color getTextColorTwo() =>
      _theme.value == 'dark' ? Colors.grey : Colors.grey.shade700;

  Color getThemeColor() => _theme.value == 'dark'
      ? const Color.fromARGB(255, 31, 37, 45)
      : Colors.white;

  void setTheme(ThemeType themeType) {
    _theme.value = themeType.toString();
    update(); // Trigger UI update
  }
}



