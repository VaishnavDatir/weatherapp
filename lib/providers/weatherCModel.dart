import 'package:flutter/foundation.dart';

class WeatherCModel with ChangeNotifier {
  final int dt;
  final int sunrise;
  final int sunset;
  final String temp;
  final String feelsLike;
  final int pressure;
  final int humidity;
  final double uvi;
  final int visibility;
  final String weather;
  final String icon;

  WeatherCModel({
    @required this.dt,
    this.sunrise,
    this.sunset,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.uvi,
    this.visibility,
    this.weather,
    this.icon,
  });
}
