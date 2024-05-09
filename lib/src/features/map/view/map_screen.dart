import 'dart:async';

import 'package:flutter/material.dart';
import 'package:siberian_coffee/src/features/map/services/location_service.dart';
import 'package:siberian_coffee/src/features/menu/models/address.dart';
import 'package:siberian_coffee/src/theme/icons_source.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapScreen extends StatefulWidget {
  final Address userCoffeeShopAddress;
  final List<Address> coffeeShopAddresses;

  const MapScreen({
    super.key,
    required this.coffeeShopAddresses,
    required this.userCoffeeShopAddress,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _mapControllerCompleter = Completer<YandexMapController>();
  final ILocationService _loacationService = LocationService();

  @override
  void initState() {
    super.initState();
    _initMap().ignore();
  }

  @override
  Widget build(BuildContext context) {
    return YandexMap(
      onMapCreated:(controller) => {
        _mapControllerCompleter.complete(controller),
      },
      mapObjects: _getPlacemarkObjects(
        context,
        widget.coffeeShopAddresses.map((address) => address.toPoint()).toList()
      ),
    );
  }

  Future<void> _initMap() async {
    bool userLocationIsAvailable = false;
    if (!await _loacationService.checkPermission()) {
      userLocationIsAvailable = await _loacationService.requestPermission();
    }
    Point startLocation = userLocationIsAvailable
        ? await _loacationService.getCurrentPosition()
        : widget.userCoffeeShopAddress.toPoint();
    _moveToLocation(startLocation);
  }

  Future<void> _moveToLocation(Point location) async {
    (await _mapControllerCompleter.future).moveCamera(
      animation: const MapAnimation(
        type: MapAnimationType.linear,
        duration: 1.0,
      ),
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: location.latitude,
            longitude: location.longitude,
          ),
        ),
      ),
    );
  }

  List<PlacemarkMapObject> _getPlacemarkObjects(BuildContext context, List<Point> points) {
    return points.map((point) => PlacemarkMapObject(
      mapId: MapObjectId('CoffeeShop: $point'), 
      point: point,
      opacity: 1,
      icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage(
            IconsSource.iconLocationPin2,
          ),
          scale: 2.5,
        )
      ),
    )).toList();
  }
}
