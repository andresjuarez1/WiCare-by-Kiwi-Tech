import 'package:flutter/material.dart';

class OrganizerInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'Información del encargado',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'PoppinsRegular',
              ),
            ),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/perfil_volunteer.jpg'),
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Christian Bumteros',
                      style: TextStyle(
                        fontFamily: 'PoppinsRegular',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                      style: TextStyle(
                        fontFamily: 'PoppinsRegular',
                        fontSize: 14.5,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
