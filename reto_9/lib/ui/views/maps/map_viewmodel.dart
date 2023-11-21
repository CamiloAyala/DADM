import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:location/location.dart';

class MapViewModel extends BaseViewModel {
  final LatLng _center = const LatLng(4.7147837, -74.0530733);
  late GoogleMapController mapController;
  final Location _location = Location();

  MapViewModel()
  {
    _getInitialLocation();
  }

  LatLng get center => _center;

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void centerCamera() async {
    final LatLng currentLocation = LatLng(
      (await _location.getLocation()).latitude!,
      (await _location.getLocation()).longitude!,
    );

    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: currentLocation,
          zoom: 15.0,
        ),
      ),
    );
  }

  void _getInitialLocation() async {
    if (!await _location.serviceEnabled()) {
      if (!await _location.requestService()) {
        return;
      }
    }

    if (await _location.hasPermission() == PermissionStatus.denied) {
      if (await _location.requestPermission() != PermissionStatus.granted) {
        return;
      }
    }
  }
}