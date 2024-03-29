import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/providers.dart';
import 'package:weather_app/providers/weather/weather_provider.dart';
import 'package:weather_app/repositories/weather_repository.dart';
import 'package:weather_app/services/weather_api_services.dart';
import 'package:http/http.dart' as http;

import 'pages/home.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<WeatherRepository>(
          create: (context) => WeatherRepository(
            weatherApiservices: WeatherAPIServices(
              httpClient: http.Client(),
            ),
          ),
        ),
        ChangeNotifierProvider<WeatherProvider>(
          create: (context) => WeatherProvider(
            weatherRepository: context.read<WeatherRepository>(),
          ),
        ),
        ChangeNotifierProvider<TempSettingsProvider>(
          create: (context) => TempSettingsProvider(),
        ),
        ChangeNotifierProxyProvider<WeatherProvider, ThemeProvider>(
          create: (context) => ThemeProvider(),
          update: (
            context,
            WeatherProvider weatherProvider,
            ThemeProvider? themeProvider,
          ) =>
              themeProvider!..update(weatherProvider),
        ),
      ],
      builder:(context, _) {
        print('theme data ${context.watch<ThemeProvider>().state.appTheme}');

        return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        // theme: ThemeData(
        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //   useMaterial3: true,
        // ),
        // theme: ThemeData.dark(),

        theme: context.watch<ThemeProvider>().state.appTheme== AppTheme.light?ThemeData.light():ThemeData.dark(),
        home: const HomeScreen(),
      );
      }
    );
  }
}
