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
          'assets/madres.jpg',
          fit: BoxFit.cover,
          color: Colors.black.withOpacity(0.5),
          colorBlendMode: BlendMode.darken,
        ),
        Positioned(          
          left: screenWidth * 0.05,
          right: screenWidth * 0.05,
          bottom: screenHeight * 0.40,
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
                  fontFamily: 'PoppinsRegular',
                  letterSpacing: 4.0,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: screenHeight * 0.015),
              Text(
                eventTitle,
                style: TextStyle(
                  fontFamily: 'PoppinsRegular',
                  fontSize: screenHeight * 0.050,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: screenHeight * 0.015),
              Text(
                'Domingo 12 de mayo - 6:00 pm',
                style: TextStyle(
                  fontFamily: 'PoppinsRegular',
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
