import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/coordinates.dart';

class Location{
  Future<LocationCoordinates> getLocation()async{
    Position position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    LocationCoordinates coordinates = LocationCoordinates(lat: position.latitude,lon: position.longitude);
    return coordinates;
  }
}