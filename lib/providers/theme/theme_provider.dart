import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/constant/constant.dart';
import 'package:weather_app/providers/providers.dart';
part 'theme_state.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeState _state = ThemeState.initial();

  ThemeState get state => _state;

  void update(WeatherProvider wp) {
    double celsiusTemperature = kelvinToCelsius(wp.state.weather.temp);
    if (celsiusTemperature > kWarnOrNot) {
      _state = _state.copyWith(appTheme: AppTheme.light);
    } else {
      _state = _state.copyWith(appTheme: AppTheme.dark);
    }
    notifyListeners();
  }
}
