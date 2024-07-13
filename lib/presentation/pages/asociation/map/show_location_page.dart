// show_location_page.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowLocationPage extends StatefulWidget {
  @override
  _ShowLocationPageState createState() => _ShowLocationPageState();
}

class _ShowLocationPageState extends State<ShowLocationPage> {
  LatLng? _savedLocation;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _loadSavedLocation();
  }

  Future<void> _loadSavedLocation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final double? latitude = prefs.getDouble('latitude');
    final double? longitude = prefs.getDouble('longitude');

    if (latitude != null && longitude != null) {
      setState(() {
        _savedLocation = LatLng(latitude, longitude);
        _markers.add(
          Marker(
            markerId: const MarkerId('savedMarker'),
            position: _savedLocation!,
            infoWindow: const InfoWindow(
              title: 'Ubicación Guardada',
              snippet: 'Esta es la ubicación seleccionada.',
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubicación Guardada'),
      ),
      body: _savedLocation == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(target: _savedLocation!, zoom: 16),
              markers: _markers,
            ),
    );
  }
}
