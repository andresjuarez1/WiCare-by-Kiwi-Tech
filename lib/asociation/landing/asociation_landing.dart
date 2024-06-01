// lib/volunteer/landing/association_landing.dart
import 'package:flutter/material.dart';
import 'components/navbar_asociation.dart';
import 'components/active_events.dart';
import 'components/volunteers_carousel.dart';

class AssociationLandingPage extends StatelessWidget {
  final List<Map<String, String>> imgList = [
    {
      'image': 'assets/messi.jpg',
      'title': 'Voluntario 1',
      'subtitle': 'Detalles del voluntario 1'
    },
    {
      'image': 'assets/messi.jpg',
      'title': 'Voluntario 2',
      'subtitle': 'Detalles del voluntario 2'
    },
    {
      'image': 'assets/messi.jpg',
      'title': 'Voluntario 3',
      'subtitle': 'Detalles del voluntario 3'
    },
  ];

  void _navigateToEvent(BuildContext context, String title) {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ActiveEvents(),
              SizedBox(height: 20), 
              VolunteersCarousel(
                imgList: imgList,
                navigateToEvent: _navigateToEvent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
