
part of 'temp_setting_provider.dart';

enum TempUnit {
  celsius,
  fahrenheit,
}

class TempSettingsState extends Equatable {
  final TempUnit tempUnit;
  const TempSettingsState({
    this.tempUnit = TempUnit.celsius,
  });

  factory TempSettingsState.initial(){
    return TempSettingsState();
  }
  

  @override
  List<Object> get props => [tempUnit];

  @override
  String toString() => 'TempSettingsState(tempUnit: $tempUnit)';

  TempSettingsState copyWith({
    TempUnit? tempUnit,
  }) {
    return TempSettingsState(
      tempUnit: tempUnit ?? this.tempUnit,
    );
  }
}
