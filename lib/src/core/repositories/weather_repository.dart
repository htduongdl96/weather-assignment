import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:weather/weather.dart';

import '../../common/constants/constants.dart';
import '../../common/utils/logger.dart';
import '../interfaces/weather_repository_interface.dart';
import '../models/weather_model.dart';

@LazySingleton(as: IWeatherRepository)
class WeatherRepository implements IWeatherRepository {
  WeatherFactory wf = WeatherFactory(Constants.weatherAPI);

  @override
  Future<WeatherModel?> getWeatherFromCityName(String cityName) async {
    Weather? wea;
    try {
      wea = await wf.currentWeatherByCityName(cityName);
    } on OpenWeatherAPIException catch (ex) {
      //case no city was found
      logger.d(ex);
      return null;
    } on SocketException catch (ex) {
      //case no internet
      logger.d(ex);
      return null;
    }
    return WeatherModel(
        locationName: wea.areaName ?? '',
        currentWeather: wea.weatherDescription ?? '',
        currentTemperature: wea.temperature?.celsius ?? 0);
  }

  @override
  Future<WeatherModel?> getWeatherFromLongLat(double long, double lat) async {
    Weather? wea;
    try {
      wea = await wf.currentWeatherByLocation(lat, long);
    } on OpenWeatherAPIException catch (ex) {
      //case no city was found
      logger.d(ex);
      return null;
    } on SocketException catch (ex) {
      //case no internet
      logger.d(ex);
      return null;
    }

    return WeatherModel(
        locationName: wea.areaName ?? '',
        currentWeather: wea.weatherDescription ?? '',
        currentTemperature: wea.temperature?.celsius ?? 0);
  }
}
