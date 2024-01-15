import 'package:flutter/material.dart';
// import 'package:weather_app/models/weather.dart';
import 'package:weather_app/pages/search.dart';
import 'package:weather_app/providers/weather/weather_provider.dart';
// import 'package:weather_app/repositories/weather_repository.dart';
// import 'package:weather_app/services/weather_api_services.dart';
// import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   _fetchWeather();
  // }

  // _fetchWeather() {
  //   // WeatherRepository(weatherApiservices: WeatherAPIServices(httpClient: http.Client())).fetchWeather('India');
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     context.read<WeatherProvider>().fetchWeather('london');
  //   });
  // }

  String? _city;

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
                if(_city!=null){
                 context.read<WeatherProvider>().fetchWeather(_city!);
                }
              },
            )
          ],
        ),
        body: const Center(
          child: Text('Weather'),
        ));
  }
}
