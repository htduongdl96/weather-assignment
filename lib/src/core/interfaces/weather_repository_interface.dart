import '../models/weather_model.dart';

abstract class IWeatherRepository {
  Future<WeatherModel?> getWeatherFromCityName(String cityName);

  Future<WeatherModel?> getWeatherFromLongLat(double long, double lat);
}
