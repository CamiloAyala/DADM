import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:reto_9/ui/views/maps/map_viewmodel.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => MapViewModel(),
      builder: (context, MapViewModel model, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Reto 9',
            style: TextStyle(color: Theme.of(context).colorScheme.background),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
              myLocationEnabled: true,
              onMapCreated: model.onMapCreated,
              initialCameraPosition: CameraPosition(
                target: model.center,
                zoom: 15.0,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: model.centerCamera,
          child: const Icon(Icons.center_focus_strong),
        ),
      ),
    );
  }
}
