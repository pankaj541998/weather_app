import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:weather_app/models/custom_error.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/repositories/weather_repository.dart';

part 'weather_state.dart';

class WeatherProvider extends ChangeNotifier {
  WeatherState _state =WeatherState.initial();

  WeatherState get state =>_state;

  final WeatherRepository weatherRepository;
  WeatherProvider({
    required this.weatherRepository,
  });


Future<void> fetchWeather(String city) async{
  _state = _state.copyWith(status:WeatherStatus.loading );
  notifyListeners();
  try {
    final Weather weather = await weatherRepository.fetchWeather(city);

    _state = _state.copyWith(status: WeatherStatus.loaded,weather: weather);
    print('_state $_state');
    notifyListeners();
  } on CustomError catch (e) {
    print('errpr $e');
    _state = _state.copyWith(status: WeatherStatus.error, error:  e);
     print('_state $_state');
    notifyListeners();
  }

}

}


