import 'dart:math';

import 'package:coba_bloc/model/weather.dart';


abstract class WeatherRepository{
  Future<Weather> fetchWeather(String cityName);
}
class FakeWeatherRepository implements WeatherRepository{
  @override
  Future<Weather> fetchWeather(String cityName)async {
    await Future.delayed(Duration(seconds: 1));
    final random = Random();

    // Simulate some network exception
    if (random.nextBool()) {
      throw NetworkException();
    }
    return Weather(cityName: cityName, temperatureCelsius: 20);
  }
}
class NetworkException implements Exception {}