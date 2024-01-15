const String kApiHost = 'api.openweathermap.org';
const String kIconHost = 'www.openweathermap.org';
const String kUnit = 'metric';
const String kLimit = '1';
const int kWarnOrNot = 20;


// kelvin to celsius convert function
  double kelvinToCelsius(double kelvin) {
    return kelvin - 273.15;
  }