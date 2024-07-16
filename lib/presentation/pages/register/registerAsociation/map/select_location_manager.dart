import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectLocationPageManager extends StatefulWidget {
  @override
  _SelectLocationPageState createState() => _SelectLocationPageState();
}

class _SelectLocationPageState extends State<SelectLocationPageManager> {
  LatLng _initialLocation = const LatLng(16.754272, -93.128144);
  LatLng? _selectedLocation;
  final Set<Marker> _markers = {};

  void _onMapTap(LatLng location) {
    setState(() {
      _selectedLocation = location;
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId('selectedMarker'),
          position: location,
          infoWindow: const InfoWindow(
            title: 'Ubicación Seleccionada',
            snippet: 'Ubicación guardada.',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    });
  }

  Future<void> _saveLocation() async {
    if (_selectedLocation != null) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('latitude_manager', _selectedLocation!.latitude);
      await prefs.setDouble('longitude_manager', _selectedLocation!.longitude);
      print('Ubicación guardada: Latitud: ${_selectedLocation!.latitude}, Longitud: ${_selectedLocation!.longitude}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ubicación guardada.')),
      );
      Navigator.pop(context, true); 
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, selecciona la ubicación.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccionar Ubicación'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(target: _initialLocation, zoom: 16),
            markers: _markers,
            onTap: _onMapTap,
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: _saveLocation,
              child: const Text('Guardar Ubicación'),
            ),
          ),
        ],
      ),
    );
  }
}
