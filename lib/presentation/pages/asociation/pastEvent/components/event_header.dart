import 'package:flutter/material.dart';

class EventHeader extends StatelessWidget {
  final String eventTitle;
  final String eventImage;
  final String eventLocation;

  EventHeader({
    required this.eventTitle,
    required this.eventImage,
    required this.eventLocation,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          eventImage,
          fit: BoxFit.cover,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black.withOpacity(0.7), Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
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
                eventLocation,
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
