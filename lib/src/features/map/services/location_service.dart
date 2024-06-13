import 'package:geolocator/geolocator.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

abstract interface class ILocationService {
  Future<Point> getCurrentPosition();
  Future<bool> requestPermission();
  Future<bool> checkPermission();
}

class LocationService implements ILocationService {
  @override
  Future<Point> getCurrentPosition() {
    return Geolocator.getCurrentPosition().then((value) => Point(
      latitude: value.latitude, 
      longitude: value.longitude,
    ));
  }

  @override
  Future<bool> requestPermission() {
    return Geolocator.requestPermission()
        .then((value) =>
            value == LocationPermission.always ||
            value == LocationPermission.whileInUse)
        .catchError((_) => false);
  }

  @override
  Future<bool> checkPermission() {
    return Geolocator.checkPermission()
        .then((value) =>
            value == LocationPermission.always ||
            value == LocationPermission.whileInUse)
        .catchError((_) => false);
  }
}
