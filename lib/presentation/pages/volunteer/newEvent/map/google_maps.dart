import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsWidget extends StatefulWidget {
  final double latitude;
  final double longitude;

  GoogleMapsWidget({
    Key? key,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  _GoogleMapsWidgetState createState() => _GoogleMapsWidgetState();
}

class _GoogleMapsWidgetState extends State<GoogleMapsWidget> {
  late LatLng location;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    location = LatLng(widget.latitude, widget.longitude);
    _markers.add(
      Marker(
        markerId: const MarkerId('location'),
        position: location,
        infoWindow: const InfoWindow(
          title: 'Ubicación',
          snippet: 'Ubicación exacta.',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.0),
        child: Container(
          color: Color(0xFF2E8139),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Dirección',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'PoppinsRegular',
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 300,
                child: GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: location, zoom: 16),
                  markers: _markers,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
