import 'package:flutter/material.dart';

class EventHeader extends StatelessWidget {
  final String eventTitle;

  EventHeader({required this.eventTitle});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/carrusel-image1.png',
          fit: BoxFit.cover,
        ),
        Positioned(
          left: screenWidth * 0.05,
          right: screenWidth * 0.05,
          bottom: screenHeight * 0.35,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'EVENTO',
                style: TextStyle(
                  fontSize: screenHeight * 0.022,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFD3FFD4),
                  letterSpacing: 4.0,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: screenHeight * 0.015),
              Text(
                eventTitle,
                style: TextStyle(
                  fontSize: screenHeight * 0.065,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: screenHeight * 0.015),
              Text(
                'Domingo 12 de mayo - 6:00 pm',
                style: TextStyle(
                  fontSize: screenHeight * 0.025,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFD3FFD4),
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
