import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/constant/constant.dart';
import 'package:weather_app/exception/weather_exception.dart';
import 'package:weather_app/models/direct_geocoding.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/http_error_handler.dart';

class WeatherAPIServices {
  final http.Client httpClient;
  WeatherAPIServices({
    required this.httpClient,
  });

  Future<DirectGeocoding> getDirectGeocordinates(String city) async {
    final Uri uri = Uri(
        scheme: 'https',
        host: kApiHost,
        path: '/geo/1.0/direct',
        queryParameters: {
          'q': city,
          'limit': kLimit,
          'appid': dotenv.env["APPID"]
        });
    try {
      final http.Response resposnse = await httpClient.get(uri);
      if (resposnse.statusCode != 200) {
        throw Exception(httpErrorHandling(resposnse));
      }

      final responsebody = jsonDecode(resposnse.body);

      if (resposnse.body.isEmpty) {
        throw WeatherException('Cannot gt the location of $city');
      }
      final directGeoCoding = DirectGeocoding.fromJson(responsebody);

      return directGeoCoding;
    } catch (e) {
      print('error occured during weather api call $e');
      rethrow;
    }
  }

  Future<Weather> getWeather(DirectGeocoding directGeocoding) async {
    final Uri uri = Uri(
        scheme: 'https',
        host: kApiHost,
        path: '/data/2.5/weather',
        queryParameters: {
          'lat': '${directGeocoding.lattitude}',
          'lon': '${directGeocoding.longitude}',
          'unit': kUnit,
          'appid': dotenv.env["APPID"]
        });
    try {
      final http.Response resposnse = await httpClient.get(uri);
      if (resposnse.statusCode != 200) {
        throw Exception(httpErrorHandling(resposnse));
      }
      
      final weatherJson = jsonDecode(resposnse.body);

      if (resposnse.body.isEmpty) {
        throw WeatherException('Cannot gt the location of $directGeocoding');
      }

      final Weather weather = Weather.fromJson(weatherJson);

      return weather;
    } catch (e) {
      print('weather api called $e');

      rethrow;
    }
  }
}
