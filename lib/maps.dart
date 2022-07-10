import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  late CameraPosition _initialCameraPosition;
  // ignore: unused_field
  late MapboxMapController _mapboxMapController;
  @override
  void initState() {
    super.initState();
    _initialCameraPosition = const CameraPosition(
      target: LatLng(
        3.5731277,
        98.6782504,
      ),
      zoom: 15,
    );
  }

  @override
  Widget build(BuildContext context) {
    _onMapCreated(MapboxMapController controller) {
      return _mapboxMapController = controller;
    }

    return Stack(
      children: [
        MapboxMap(
          onMapCreated: _onMapCreated,
          accessToken: '',
          initialCameraPosition: _initialCameraPosition,
          // myLocationEnabled: false,
          // myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
          // minMaxZoomPreference: const MinMaxZoomPreference(14, 17),
        ),
      ],
    );
  }
}
