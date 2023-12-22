part of './models_library.dart';

class WeatherModel {
  String name;
  List<WeeklyWeather> weeklyWeather;

  WeatherModel({
    required this.name,
    required this.weeklyWeather,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        name: json["name"],
        weeklyWeather: List<WeeklyWeather>.from(
            json["weekly_weather"].map((x) => WeeklyWeather.fromJson(x))),
      );
}

class WeeklyWeather {
  String mainTemp;
  String mainWind;
  String mainHumidity;
  String mainImg;
  String day;
  AllTime allTime;

  WeeklyWeather({
    required this.mainTemp,
    required this.mainWind,
    required this.mainHumidity,
    required this.mainImg,
    required this.day,
    required this.allTime,
  });

  factory WeeklyWeather.fromJson(Map<String, dynamic> json) => WeeklyWeather(
        mainTemp: json["main_temp"],
        mainWind: json["main_wind"],
        mainHumidity: json["main_humidity"],
        mainImg: json["main_img"],
        day: json["day"],
        allTime: AllTime.fromJson(json["all_time"]),
      );
}

class AllTime {
  List<String>? hour;
  List<String>? wind;
  List<String>? img;
  List<String>? temps;

  AllTime({
    this.hour,
    this.wind,
    this.img,
    this.temps,
  });

  factory AllTime.fromJson(Map<String, dynamic> json) => AllTime(
        hour: json["hour"] == null
            ? []
            : List<String>.from(json["hour"]!.map((x) => x)),
        wind: json["wind"] == null
            ? []
            : List<String>.from(json["wind"]!.map((x) => x)),
        img: json["img"] == null
            ? []
            : List<String>.from(json["img"]!.map((x) => x!)),
        temps: json["temps"] == null
            ? []
            : List<String>.from(json["temps"]!.map((x) => x)),
      );
}
