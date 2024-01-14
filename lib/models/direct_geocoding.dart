import 'package:equatable/equatable.dart';

class DirectGeocodig extends Equatable {
  final String name;
  final double lattitude;
  final double longitude;
  final String country;
  const DirectGeocodig({
    required this.name,
    required this.lattitude,
    required this.longitude,
    required this.country,
  });

  factory DirectGeocodig.fromJson(List<dynamic>json){
    final Map<String,dynamic> data = json[0];
    return DirectGeocodig(name: data["name"], lattitude: data["lat"], longitude: data["lon"], country: data["country"],);
  }


  @override
  List<Object> get props => [name, lattitude, longitude, country];

  @override
  String toString() {
    return 'DirectGeocodig(name: $name, lattitude: $lattitude, longitude: $longitude, country: $country)';
  }
}
