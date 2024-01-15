import 'package:equatable/equatable.dart';

class DirectGeocoding extends Equatable {
  final String name;
  final double lattitude;
  final double longitude;
  final String country;
  const DirectGeocoding({
    required this.name,
    required this.lattitude,
    required this.longitude,
    required this.country,
  });

  factory DirectGeocoding.fromJson(List<dynamic>json){
    final Map<String,dynamic> data = json[0];
    return DirectGeocoding(name: data["name"], lattitude: data["lat"], longitude: data["lon"], country: data["country"],);
  }


  @override
  List<Object> get props => [name, lattitude, longitude, country];

  @override
  String toString() {
    return 'DirectGeocoding(name: $name, lattitude: $lattitude, longitude: $longitude, country: $country)';
  }
}
