// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
import 'package:weather_app/constant/constant.dart';
// import 'package:weather_app/models/weather.dart';
import 'package:weather_app/pages/search.dart';
import 'package:weather_app/pages/setting.dart';
import 'package:weather_app/providers/providers.dart';
import 'package:weather_app/providers/weather/weather_provider.dart';
// import 'package:weather_app/repositories/weather_repository.dart';
// import 'package:weather_app/services/weather_api_services.dart';
// import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:weather_app/widgets/error_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _city;
  late final WeatherProvider _weatherProv;
  @override
  void initState() {
    super.initState();
    _weatherProv = context.read<WeatherProvider>();
    _weatherProv.addListener(_registerListner);
  }

  @override
  void dispose() {
    super.dispose();
    _weatherProv.removeListener(_registerListner);
  }

  void _registerListner() {
    final WeatherState ws = context.read<WeatherProvider>().state;
    if (ws.status == WeatherStatus.error) {
      errorDialog(context, ws.error.errMsg);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Weather'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () async {
                _city = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchScreen(),
                  ),
                );
                print('_city $_city');
                if (_city != null) {
                  context.read<WeatherProvider>().fetchWeather(_city!);
                }
              },
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.settings)),
          ],
        ),
        body: _showWeather());
  }

  String showTemperature(double temperature) {
    double celsiusTemperature =
        kelvinToCelsius(temperature); //default temp is kelvin so, that why converstio  is require.
    final tempUnit = context.watch<TempSettingsProvider>().state.tempUnit;

    if (tempUnit == TempUnit.fahrenheit) {
      return '${((celsiusTemperature * 9 / 5) + 32).toStringAsFixed(2)}℉';
    }
    return '${celsiusTemperature.toStringAsFixed(2)}℃';
  }

  Widget _showWeather() {
    final state = context.watch<WeatherProvider>().state;
    if (state.status == WeatherStatus.initial) {
      return const Center(
        child: Text(
          'Select a City',
          style: TextStyle(fontSize: 20.0),
        ),
      );
    }

    if (state.status == WeatherStatus.error && state.weather.name == '') {
      return const Center(
        child: Text(
          'Select a City',
          style: TextStyle(fontSize: 20.0),
        ),
      );
    }
    if (state.status == WeatherStatus.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return ListView(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height / 6),
        Text(
          state.weather.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              TimeOfDay.fromDateTime(state.weather.lastUpdated).format(context),
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(width: 10),
            Text(
              '(${state.weather.country})',
              style: const TextStyle(fontSize: 18.0),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              showTemperature(state.weather.temp),
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 20),
            Column(
              children: [
                Text(
                  showTemperature(state.weather.tempMax),
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Text(
                  showTemperature(state.weather.tempMin),
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Spacer(),
            showIcon(state.weather.icon),
            Expanded(flex: 3, child: formateText(state.weather.description)),
            const Spacer(),
          ],
        ),
      ],
    );
  }

  Widget showIcon(String icon) {
    return FadeInImage.assetNetwork(
      width: 100,
      height: 100,
      placeholder: 'assets/loadig.gif',
      image: 'http://$kIconHost/img/wn/$icon@4x.png',
    );
  }

  Widget formateText(String description) {
    final foramttedStribg = description.titleCase;
    return Text(
      foramttedStribg,
      style: const TextStyle(fontSize: 22),
    );
  }
}
