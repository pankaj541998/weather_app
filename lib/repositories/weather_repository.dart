import 'package:weather_app/exception/weather_exception.dart';
import 'package:weather_app/models/custom_error.dart';
import 'package:weather_app/models/direct_geocoding.dart';
import 'package:weather_app/services/weather_api_services.dart';

import '../models/weather.dart';

class WeatherRepository {
  final WeatherAPIServices weatherApiservices;
  WeatherRepository({
    required this.weatherApiservices,
  });

  Future<Weather> fetchWeather(String city) async {
    try {
      final DirectGeocoding directGeocoding =
          await weatherApiservices.getDirectGeocordinates(city);

      print('directGeocoding: $directGeocoding');

      final Weather tempWeather =
          await weatherApiservices.getWeather(directGeocoding);

      final Weather weather = tempWeather.copyWith(
        name: directGeocoding.name,
        country: directGeocoding.country,
      );
      return weather;
    } on WeatherException catch (e) {
      print(e);
      throw CustomError(errMsg: e.message);
    } catch (e) {
      print(e);
      throw CustomError(errMsg: e.toString());
    }
  }
}
