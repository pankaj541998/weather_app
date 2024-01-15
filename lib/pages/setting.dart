import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/providers.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          title: const Text('Temperature Unit'),
          subtitle: const Text('Celsius/Fahrenheit (Default: Celsius)'),
          trailing: Switch(value: context.watch<TempSettingsProvider>().state.tempUnit == TempUnit.celsius, onChanged: (_){
            context.read<TempSettingsProvider>().toggleTempUnit();
          }),
        ),
      ),
    );
  }
}
