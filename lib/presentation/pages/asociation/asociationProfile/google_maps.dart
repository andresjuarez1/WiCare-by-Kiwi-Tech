import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({super.key});

  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  static const googlePlex = LatLng(16.754272, -93.128144);
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _markers.add(
      Marker(
        markerId: const MarkerId('googlePlex'),
        position: googlePlex,
        infoWindow: const InfoWindow(
          title: 'Ubicación',
          snippet: 'Ubicación exacta.',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: GoogleMap(
          initialCameraPosition: const CameraPosition(target: googlePlex, zoom: 16),
          markers: _markers,
        ),
      );
}
